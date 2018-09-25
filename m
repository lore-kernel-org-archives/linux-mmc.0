From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
Date: Tue, 25 Sep 2018 21:24:33 +0200
Message-ID: <20180925192433.1377-1-jmkrzyszt@gmail.com>
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
get/set array") changed the way GPIO values are passed to
gpiod_get/set_array_value() and friends.  The updated code of
mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
argument as a bitmap of GPIO values and assigns it directly to the
'values' bitmap variable passed to gpiod_set_array_value_cansleep()
instead of filling that bitmap with bits equal to the 'value' argument.
As a result, boot hanging caused by incorrectly handled MMC device
has been observed.

As a side effect of that incorrect interpreation of the 'value'
argument, wrong assumption is taken about the 'values' bitmap size 
never exceding the number of bits of the 'value' argument type.

Fix it.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Hi,

I hope I've finally identified the root cause of the boot hang reported
by Marek Szyprowski.  I've reviewed the code of other divers updated for
the modified GPIO API and found no more issues of that kind.

Marek, can you please test this fix on top of next-20180920 with the fix
"gpiolib: Fix missing updates of bitmap index" also applied?

I've assumed this fix, if tested successfully, will be merged via GPIO
tree, hence I've selected Linus as the main recipient of this message.

Thanks,
Janusz

 drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 7f882a2bb872..ece34c734693 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
+		unsigned long *values;
 		int nvalues = reset_gpios->ndescs;
 
-		values[0] = value;
+		values = bitmap_alloc(nvalues, GFP_KERNEL);
+		if (!values)
+			return;
+
+		if (value)
+			bitmap_fill(values, nvalues);
+		else
+			bitmap_zero(values, nvalues);
 
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
 					       reset_gpios->info, values);
+
+		kfree(values);
 	}
 }
 
-- 
2.16.4
