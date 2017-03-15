From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] mmc: core: check also R1 response for stop commands
Date: Wed, 15 Mar 2017 02:54:06 +0000
Message-ID: <PS1PR06MB1692B56C7B571EBB02EB23C1D8270@PS1PR06MB1692.apcprd06.prod.outlook.com>
References: <20170314101501.25463-1-wsa+renesas@sang-engineering.com>
 <PS1PR06MB16924720592DB11B43DD5AF0D8240@PS1PR06MB1692.apcprd06.prod.outlook.com>
 <20170314104904.4ig62cy2w6fkpqzm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170314104904.4ig62cy2w6fkpqzm@ninjato>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram-san,=20

> From: Wolfram Sang, Sent: Tuesday, March 14, 2017 7:49 PM
>=20
> > > So, since I got no complaints about the RFC, I'll declare it a PATCH =
now :)
> > > Shimoda-san, is it possible for you to test it with the SD tester you=
 once had
> > > access to? I could only test it by setting the ECC bit in the driver =
manually.
> >
> > Sure. I am able to bring the SD tester from other department tomorrow.
> > So, I will check this patch tomorrow.
>=20
> Good news, thank you very much!

I tested this patch with the SD tester. After I applied this patch, when th=
e R1_CARD_ECC_FAILED
is set, the following message appeared:

mmcblk1: error -5 sending stop command, original cmd response 0x900, card s=
tatus 0x900

However, I have a question about "ecc_err" in both mmc_blk_err_check() and =
mmc_blk_cmd_recovery().
Anyway, I tested this patch. And the mmc core said some error happened.
I think this is suitable behavior. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

< Question >
In mmc_blk_cmd_recovery(), if "brq->stop.resp[0] & R1_CARD_ECC_FAILED" is t=
rue, ecc_err is set to true.
However, in mmc_blk_err_check(), ecc_err is only referred when brq->data.er=
ror is true.
So, I guess we need a patch like below as another patch. What do you think?

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0e838b0..99c937b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1374,7 +1374,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct m=
mc_ca
                return MMC_BLK_RETRY;
        }

-       if (brq->data.error) {
+       if (brq->data.error || ecc_err) {
                if (need_retune && !brq->retune_retry_done) {
                        pr_debug("%s: retrying because a re-tune was needed=
\n",
                                 req->rq_disk->disk_name);

After that, the mmc core also output the following message:

mmcblk1: error 0 transferring data, sector 0, nr 128, cmd response 0x900, c=
ard status 0x200b00
mmcblk1: retrying using single block read

Best regards,
Yoshihiro Shimoda
