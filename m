From: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>
Subject: [PATCH 3/3] mmc: sdhci: Modify sdhci o2 quirk for eMMC HS200 tuning
 case
Date: Mon, 4 Dec 2017 10:10:57 +0000
Message-ID: <CY4PR04MB047345A73648C7A212D505D7ED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
References: <BN1PR04MB4543C8987923D893F407934893C0@BN1PR04MB454.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:46808
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751636AbdLDKK7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Dec 2017 05:10:59 -0500
In-Reply-To: <BN1PR04MB4543C8987923D893F407934893C0@BN1PR04MB454.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>

Dear all,

Don't clear transfer mode register in sdhci_set_transfer_mode().

In sdhci_set_transfer_mode(), clear transfer mode quirk2 will clear SD host=
 transfer mode register for non-data commands. This quirk is used for the b=
ug of O2micro/Bayhubtech devices. In eMMC HS200 tuning case, the tuning pro=
cess uses hardware tuning and it needs to set transfer mode register for tu=
ning command.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index 0d5f=
cca18c9e..d5b19fc9ea56 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -918,7 +918,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *=
host,
 	if (data =3D=3D NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
-			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+			/* cannot clear transfer mode register when tuning */
+			if (cmd->opcode !=3D MMC_SEND_TUNING_BLOCK_HS200)
+				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
 			mode =3D sdhci_readw(host, SDHCI_TRANSFER_MODE);
--
2.14.1
