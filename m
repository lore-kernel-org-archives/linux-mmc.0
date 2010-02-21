From: d binderman <dcb314@hotmail.com>
Subject: drivers/mmc/card/queue.c: 5 * redundant conditions
Date: Sun, 21 Feb 2010 09:21:27 +0000
Message-ID: <BLU108-W228981D80AF186D993C529C440@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_40e80905-bc8f-4312-bb18-d8583206c59e_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from blu0-omc1-s22.blu0.hotmail.com ([65.55.116.33]:24239 "EHLO
	blu0-omc1-s22.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755010Ab0BUJV2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Feb 2010 04:21:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--_40e80905-bc8f-4312-bb18-d8583206c59e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hello there=2C

I just ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.33-rc8

It said

Checking ./drivers/mmc/card/queue.c...
[./drivers/mmc/card/queue.c:212]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/mmc/card/queue.c:215]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/mmc/card/queue.c:208]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/mmc/card/queue.c:239]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/mmc/card/queue.c:246]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer

I checked the source code and I agree with cppcheck.=20
Patch file attached.

Regards

David Binderman

 		 	   		 =20
_________________________________________________________________
Got a cool Hotmail story? Tell us now
http://clk.atdmt.com/UKM/go/195013117/direct/01/=

--_40e80905-bc8f-4312-bb18-d8583206c59e_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bug30.patch"

LS0tIGRyaXZlcnMvbW1jL2NhcmQvcXVldWUuYy5zYXYJMjAxMC0wMi0yMSAwOTowODo0NS4wMDAw
MDAwMDAgKzAwMDAKKysrIGRyaXZlcnMvbW1jL2NhcmQvcXVldWUuYwkyMDEwLTAyLTIxIDA5OjA5
OjUxLjAwMDAwMDAwMCArMDAwMApAQCAtMjA1LDE1ICsyMDUsMTIgQEAgaW50IG1tY19pbml0X3F1
ZXVlKHN0cnVjdCBtbWNfcXVldWUgKm1xLAogCiAJcmV0dXJuIDA7CiAgZnJlZV9ib3VuY2Vfc2c6
Ci0gCWlmIChtcS0+Ym91bmNlX3NnKQotIAkJa2ZyZWUobXEtPmJvdW5jZV9zZyk7CisJa2ZyZWUo
bXEtPmJvdW5jZV9zZyk7CiAgCW1xLT5ib3VuY2Vfc2cgPSBOVUxMOwogIGNsZWFudXBfcXVldWU6
Ci0gCWlmIChtcS0+c2cpCi0JCWtmcmVlKG1xLT5zZyk7CisJa2ZyZWUobXEtPnNnKTsKIAltcS0+
c2cgPSBOVUxMOwotCWlmIChtcS0+Ym91bmNlX2J1ZikKLQkJa2ZyZWUobXEtPmJvdW5jZV9idWYp
OworCWtmcmVlKG1xLT5ib3VuY2VfYnVmKTsKIAltcS0+Ym91bmNlX2J1ZiA9IE5VTEw7CiAJYmxr
X2NsZWFudXBfcXVldWUobXEtPnF1ZXVlKTsKIAlyZXR1cm4gcmV0OwpAQCAtMjM2LDE1ICsyMzMs
MTMgQEAgdm9pZCBtbWNfY2xlYW51cF9xdWV1ZShzdHJ1Y3QgbW1jX3F1ZXVlCiAJYmxrX3N0YXJ0
X3F1ZXVlKHEpOwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUocS0+cXVldWVfbG9jaywgZmxhZ3Mp
OwogCi0gCWlmIChtcS0+Ym91bmNlX3NnKQotIAkJa2ZyZWUobXEtPmJvdW5jZV9zZyk7CisJa2Zy
ZWUobXEtPmJvdW5jZV9zZyk7CiAgCW1xLT5ib3VuY2Vfc2cgPSBOVUxMOwogCiAJa2ZyZWUobXEt
PnNnKTsKIAltcS0+c2cgPSBOVUxMOwogCi0JaWYgKG1xLT5ib3VuY2VfYnVmKQotCQlrZnJlZSht
cS0+Ym91bmNlX2J1Zik7CisJa2ZyZWUobXEtPmJvdW5jZV9idWYpOwogCW1xLT5ib3VuY2VfYnVm
ID0gTlVMTDsKIAogCW1xLT5jYXJkID0gTlVMTDsK

--_40e80905-bc8f-4312-bb18-d8583206c59e_--
