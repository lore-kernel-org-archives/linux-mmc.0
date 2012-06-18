From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH 2/2] sound: tegra_alc5632: Adjust to of_get_named_gpio() change
Date: Mon, 18 Jun 2012 18:42:22 +0200
Message-ID: <1340037743-12924-2-git-send-email-stigge@antcom.de>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340037743-12924-1-git-send-email-stigge@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Roland Stigge <stigge@antcom.de>
List-Id: linux-mmc@vger.kernel.org

of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
gpios not probed yet. This patch adjusts tegra_alc5632 to this.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git,
branch for-next

 sound/soc/tegra/tegra_alc5632.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index d684df2..e463529 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -177,7 +177,7 @@ static __devinit int tegra_alc5632_probe(struct platform_device *pdev)
 	}
 
 	alc5632->gpio_hp_det = of_get_named_gpio(np, "nvidia,hp-det-gpios", 0);
-	if (alc5632->gpio_hp_det == -ENODEV)
+	if (alc5632->gpio_hp_det == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
 	ret = snd_soc_of_parse_card_name(card, "nvidia,model");
-- 
1.7.10
