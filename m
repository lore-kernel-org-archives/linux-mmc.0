From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Fri, 11 Mar 2011 17:18:07 +0000
Message-ID: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:38494 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750981Ab1CKRSQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 12:18:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

New IO FPGA implementation for Versatile Express boards contain
MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mmc/host/mmci.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2d6de3e..e7197b0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -66,6 +66,12 @@ static struct variant_data variant_arm =3D {
 =09.datalength_bits=09=3D 16,
 };
=20
+static struct variant_data variant_arm_extended_fifo =3D {
+=09.fifosize=09=09=3D 128 * 4,
+=09.fifohalfsize=09=09=3D 64 * 4,
+=09.datalength_bits=09=3D 16,
+};
+
 static struct variant_data variant_u300 =3D {
 =09.fifosize=09=09=3D 16 * 4,
 =09.fifohalfsize=09=09=3D 8 * 4,
@@ -1019,10 +1025,15 @@ static int mmci_resume(struct amba_device *dev)
 static struct amba_id mmci_ids[] =3D {
 =09{
 =09=09.id=09=3D 0x00041180,
-=09=09.mask=09=3D 0x000fffff,
+=09=09.mask=09=3D 0xff0fffff,
 =09=09.data=09=3D &variant_arm,
 =09},
 =09{
+=09=09.id=09=3D 0x01041180,
+=09=09.mask=09=3D 0xff0fffff,
+=09=09.data=09=3D &variant_arm_extended_fifo,
+=09},
+=09{
 =09=09.id=09=3D 0x00041181,
 =09=09.mask=09=3D 0x000fffff,
 =09=09.data=09=3D &variant_arm,
--=20
1.6.3.3


