From: "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>
Subject: Enabling RPMB overwrites setting the boot partition via ioctl
Date: Fri, 19 May 2017 22:03:40 +0000
Message-ID: <BN6PR12MB1442FDD4A02698E52489183490E50@BN6PR12MB1442.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-001d2f02.pphosted.com ([148.163.157.190]:59878 "EHLO
        mx0a-001d2f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753835AbdESWDn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 18:03:43 -0400
Received: from pps.filterd (m0089636.ppops.net [127.0.0.1])
        by mx0a-001d2f02.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4JLvVW0029671
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 15:03:43 -0700
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0176.outbound.protection.outlook.com [216.32.180.176])
        by mx0a-001d2f02.pphosted.com with ESMTP id 2aj49shdwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 15:03:43 -0700
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Linux kernel: 4.1.15 (imx_4.1.15_1.0.0_ga branch)

I've noticed that writing to the boot partition is overwritten by RPMB rela=
ted functions as it stores this byte (card->ext_csd.part_conf). It is neces=
sary to update this reference when issuing CMD6 SWITCH through ioctl. See b=
elow patch for above kernel version:

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index be776fa..cbd0533 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -60,7 +60,9 @@ MODULE_ALIAS("mmc:block");
#define INAND_CMD38_ARG_SECTRIM2 0x88
#define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
#define MMC_SANITIZE_REQ_TIMEOUT 240000
-#define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_SWITCH_MODE_FROM_ARG(x)  (((x) & 0x03000000) >> 24)
+#define MMC_EXTRACT_INDEX_FROM_ARG(x)        (((x) & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x)        (((x) & 0x0000FF00) >> 8)

 #define mmc_req_rel_wr(req)   (((req->cmd_flags & REQ_FUA) || \
                                (req->cmd_flags & REQ_META)) && \
@@ -572,6 +574,24 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev=
,
              goto cmd_rel_host;
       }

+       /* If writing part config register, update struct */
+       if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) =3D=3D EXT_CSD_PART_CONFIG=
) &&
+           (cmd.opcode =3D=3D MMC_SWITCH)) {
+              u8 mode =3D MMC_EXTRACT_SWITCH_MODE_FROM_ARG(cmd.arg);
+              u8 value =3D MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+              switch (mode) {
+              case MMC_SWITCH_MODE_SET_BITS:
+                      card->ext_csd.part_config |=3D value;
+                      break;
+              case MMC_SWITCH_MODE_CLEAR_BITS:
+                      card->ext_csd.part_config &=3D ~value;
+                      break;
+              case MMC_SWITCH_MODE_WRITE_BYTE:
+                      card->ext_csd.part_config =3D value;
+                      break;
+              }
+       }
+
       /*
        * According to the SD specs, some commands require a delay after
        * issuing the command.
________________________________
________________________________


Please be advised that this email may contain confidential information. If =
you are not the intended recipient, please notify us by email by replying t=
o the sender and delete this message. The sender disclaims that the content=
 of this email constitutes an offer to enter into, or the acceptance of, an=
y agreement; provided that the foregoing does not invalidate the binding ef=
fect of any digital or other electronic reproduction of a manual signature =
that is included in any attachment.
