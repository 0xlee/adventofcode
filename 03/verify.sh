#!/bin/bash

E1=106501
R1=$(crystal run1.cr)
[ "$R1" -eq "$E1" ] || echo "Expected result $E1 but found $R1"

E2=632
R2=$(crystal run2.cr)
[ "$R2" -eq "$E2" ] || echo "Expected result $E2 but found $R2"
