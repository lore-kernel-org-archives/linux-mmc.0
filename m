From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT property for broken voltage quirk
Date: Wed, 19 Sep 2012 10:39:48 -0400
Message-ID: <m3wqzqf557.fsf@pullcord.laptop.org>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
	<1587150.uFGRdL0s8e@amdc1227> <m3a9wmgvip.fsf@pullcord.laptop.org>
	<1907099.4JSZthrgh2@amdc1227> <m3627aguhl.fsf@pullcord.laptop.org>
	<5059A64D.6000700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5059A64D.6000700@samsung.com> (Jaehoon Chung's message of "Wed,
	19 Sep 2012 20:02:37 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Sep 19 2012, Jaehoon Chung wrote:
>> On Wed, Sep 19 2012, Tomasz Figa wrote:
>>> We could just check if the regulator provides the capability to change the 
>>> voltage.
>>>
>>> I don't see any direct way of querying the regulator for provided 
>>> capabilities (correct me if I'm just blind), but calling 
>>> regulator_count_voltages() on the regulator and checking if the returned 
>>> value is 1 should be enough to assume that the regulator is fixed.
>> 
>> Sounds good, I agree.  Are you able to test that the obvious patch below
>> works on your fixed-regulator board?
>> 
>> Jaehoon and Adrian, can you think of any reason why we shouldn't replace
>> MMC_CAP2_BROKEN_VOLTAGE with the regulator_count_voltages() call below?
>> Thanks.
>
> I think this is better than using MMC_CAP2_BROKEN_VOLTAGE.
> I tested with this..and working fine.

Great, here's the patch.  Jaehoon, once this is merged, maybe you could
help remove the uses of MMC_CAP2_BROKEN_VOLTAGE from arch/arm/mach-exynos
and arch/arm/mach-s5pv210 now that they're no longer needed?

Thanks,

- Chris.


Subject: [PATCH] mmc: core: Replace MMC_CAP2_BROKEN_VOLTAGE with test for fixed regulator

Before this patch, we were using MMC_CAP2_BROKEN_VOLTAGE as a way to
avoid calling regulator_set_voltage() on a fixed regulator, but that's
just duplicating information that already exists -- we should test
whether the regulator is fixed directly, instead of via a capability.

This patch implements that test.  We can't reclaim the capability bit
just yet, since there are still boards in arch/arm/ that reference it;
those references can be removed now.

Reported-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 044cd01..6612163 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1113,7 +1113,8 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 		int		tmp;
 		int		voltage;
 
-		/* REVISIT mmc_vddrange_to_ocrmask() may have set some
+		/*
+		 * REVISIT mmc_vddrange_to_ocrmask() may have set some
 		 * bits this regulator doesn't quite support ... don't
 		 * be too picky, most cards and regulators are OK with
 		 * a 0.1V range goof (it's a small error percentage).
@@ -1127,12 +1128,13 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			max_uV = min_uV + 100 * 1000;
 		}
 
-		/* avoid needless changes to this voltage; the regulator
-		 * might not allow this operation
+		/*
+		 * If we're using a fixed/static regulator, don't call
+		 * regulator_set_voltage; it would fail.
 		 */
 		voltage = regulator_get_voltage(supply);
 
-		if (mmc->caps2 & MMC_CAP2_BROKEN_VOLTAGE)
+		if (regulator_count_voltages(supply) == 1)
 			min_uV = max_uV = voltage;
 
 		if (voltage < 0)
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
