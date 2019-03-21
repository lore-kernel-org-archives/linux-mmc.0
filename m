From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: =?utf-8?B?UmU6IFtQQVRDSCAyLzJdIG1tYzogZHdfbW1jLXJvY2tjaGlwOiBm?=
 =?utf-8?B?aXggdHJhbnNmZXIgaGFuZ3Mgb24gcmszMTg444CQ6K+35rOo5oSP77yM6YKu?=
 =?utf-8?B?5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkQ==?=
 =?utf-8?B?44CR?=
Date: Thu, 21 Mar 2019 13:32:48 +0300
Message-ID: <AD704EA2-15A1-4474-8282-D4F9AD7B5C28@gmail.com>
References: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
 <1553104085-32312-3-git-send-email-al.kochet@gmail.com>
 <8293b346-15a0-a70d-1bfd-c9b2251c729c@rock-chips.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8293b346-15a0-a70d-1bfd-c9b2251c729c@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, LAK <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wxt@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hello!

Forgot to mention transfer hags happen only on mem to dev transfers (dma =
writes to
device) and never on dev to mem.

Yea, I know, rk3188 and earlier are quite ancient, but we made custom =
hardware
based on rk3188 and some of our customers report problems.

For testing I use rk3188 based custom board with eMMC (probably =
rk3188-radxa rock
with SD can also be used for testing) with cpufreq	enabled.

For testing I made simple script, that do in loop following:
1. Creates 6 new empty partitions using mkfs.ext3 about 1Gb total
2. extract 100MB archive of linux image to 512Mb partition (about 400MB =
extracted size).
3. sleep random time from 60 to 120 sec

CPU load looks like that:
cpufreq stats: 312 MHz:32.63%, 504 MHz:0.00%, 600 MHz:0.00%, 816 =
MHz:0.38%, 1.01 GHz:29.83%, 1.20 GHz:0.38%, 1.42 GHz:0.00%, 1.61 =
GHz:36.79%  (494481)

This test can run for 6 hours and than transfer can hang. I used 5 =
devices to test. Some
devices may run test for long time, but some may fail within an hour.

I played with CPU clock settings in u-boot and mmc bus clock settings =
dts file. I tried to lower eMMC bus
clock frequency to exclude PCB errors. Found that some combinations of =
settings
make my test run longer, but test fail anyway.

Also I found, that making following change to dw_mmc, result in high =
error count:

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9c54d60..dcf7d36e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2905,10 +2905,9 @@ static int dw_mci_init_slot(struct dw_mci *host)
        } else if (host->use_dma =3D=3D TRANS_MODE_EDMAC) {
                mmc->max_segs =3D 64;
                mmc->max_blk_size =3D 65535;
-               mmc->max_blk_count =3D 65535;
-               mmc->max_req_size =3D
-                               mmc->max_blk_size * mmc->max_blk_count;
-               mmc->max_seg_size =3D mmc->max_req_size;
+               mmc->max_seg_size =3D 0x1000;
+               mmc->max_req_size =3D mmc->max_seg_size * mmc->max_segs;
+               mmc->max_blk_count =3D mmc->max_req_size / 512;
        } else {
                /* TRANS_MODE_PIO */
                mmc->max_segs =3D 64;

With this settings mmc core split large transfer to multiply item =
scatterlists and
increase scatterlists  switching rate inside pl330. So I assumed that =
the root of problem
is dma goes out of sync with device.

For, example, there is a patch in mainline linux:
=
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dr=
ivers/dma/pl330.c?h=3Dv5.0.3&id=3D1d48745b192a7a45bbdd3557b4c039609569ca41=

It fix the problem EDMA can get out of sync with device. But the patch =
don=E2=80=99t work for rk3188, because
rk3188 has PL330_QUIRK_BROKEN_NO_FLUSHP quirk.

I=E2=80=99ll try to backport EDMA driver from vendor 4.4 kernel and =
report test result.

Problem safer to fix patching dw_mmc code, than pl330 code. Because
patch change transfer parameters from known to work values:

                mmc->max_segs =3D 64;
                mmc->max_blk_size =3D 65535;
                mmc->max_blk_count =3D 65535;
                mmc->max_req_size =3D
                               mmc->max_blk_size * mmc->max_blk_count;
                mmc->max_seg_size =3D mmc->max_req_size;

to

		mmc->max_segs =3D 1;
		mmc->max_blk_size =3D 65535;
		mmc->max_blk_count =3D 64 * 512;
		mmc->max_req_size =3D
				mmc->max_blk_size * mmc->max_blk_count;
		mmc->max_seg_size =3D mmc->max_req_size;


> 21 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2019 =D0=B3., =D0=B2 5:31, Shawn Lin =
<shawn.lin@rock-chips.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>=20
> + Caesar Wang
>=20
> On 2019/3/21 1:48, Alexander Kochetkov wrote:
>> I've found that sometimes dw_mmc in my rk3188 based board stop =
transfer
>> any data with error:
>> kernel: dwmmc_rockchip 1021c000.dwmmc: Unexpected command timeout, =
state 3
>> Further digging into problem showed that sometimes one of EDMA-based
>> transfers hangs and abort with HTO error. I've made test, that 100%
>=20
> I'm not sure what 100% means, but Caesar fired QA test for RK3036 with
> EDMA-based dwmmc in vendor 4.4 kernel, and seems not big deal. The
> vendor 4.4 kernel didn't patch anything else wrt EDMA code, but we did
> enhance PL330 code and fix some bug there, so you may have a try.
>=20
>> reproduce the error. I found, that setting max_segs parameter to 1 =
fix
>> the problem.
>> I guess the problem is hardware related and relates to DMA controller
>> implementation for rk3188. Probably it can relates to missed FLUSHP,
>> see commit 271e1b86e691 ("dmaengine: pl330: add quirk for broken no
>> flushp"). It is possible that pl330 and dw_mmc become out of sync =
then
>> pl330 driver switch from one scatterlist to another. If we limit
>> scatterlist size to 1, we can avoid switching scatterlists and avoid
>> hardware problem. Setting max_segs to 1 tells mmc core to use maximum
>> one scatterlist for one transfer.
>> I guess that all other rk3xxx chips that lacks FLUSHP also affected =
by
>> the problem. So I made fix for all rk3xxx chips from rk2928 to =
rk3188.
>=20
> Hard to find these acient platforms to test, expecially some was =
EOL....
>=20
>> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
>> ---
>>  drivers/mmc/host/dw_mmc-rockchip.c |   19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c =
b/drivers/mmc/host/dw_mmc-rockchip.c
>> index 8c86a80..2eed922 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -292,6 +292,24 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci =
*host)
>>  	return 0;
>>  }
>>  +static void dw_mci_rk2928_init_slot(struct dw_mci *host)
>> +{
>> +	struct mmc_host *mmc =3D host->slot->mmc;
>> +
>> +	if (host->use_dma =3D=3D TRANS_MODE_EDMAC) {
>> +		/*
>> +		 * Using max_segs > 1 leads to rare EDMA transfer hangs
>> +		 * resulting in HTO errors.
>> +		 */
>> +		mmc->max_segs =3D 1;
>> +		mmc->max_blk_size =3D 65535;
>> +		mmc->max_blk_count =3D 64 * 512;
>> +		mmc->max_req_size =3D
>> +				mmc->max_blk_size * mmc->max_blk_count;
>> +		mmc->max_seg_size =3D mmc->max_req_size;
>> +	}
>> +}
>> +
>>  static int dw_mci_rockchip_init(struct dw_mci *host)
>>  {
>>  	/* It is slot 8 on Rockchip SoCs */
>> @@ -314,6 +332,7 @@ static int dw_mci_rockchip_init(struct dw_mci =
*host)
>>    static const struct dw_mci_drv_data rk2928_drv_data =3D {
>>  	.init			=3D dw_mci_rockchip_init,
>> +	.init_slot		=3D dw_mci_rk2928_init_slot,
>>  };
>>    static const struct dw_mci_drv_data rk3288_drv_data =3D {
>=20
>=20
