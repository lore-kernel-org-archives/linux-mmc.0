From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 0/3] If an IRQ is a GPIO, request and configure it
Date: Thu,  4 Aug 2011 17:00:17 -0600
Message-ID: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

In http://www.spinics.net/lists/linux-tegra/msg01731.html, Mark Brown
pointed out that it was a little silly forcing every board or driver
to gpio_request() a GPIO that is later converted to an IRQ, and passed
to request_irq. The first patch in this series instead makes the core
IRQ code perform these calls when appropriate, to avoid duplicating it
everywhere.

However, this change has the potential for significant regressions; at
least some drivers are already calling gpio_request for GPIOs that are
also used as IRQs. This then causes the gpio_request inside the core IRQ
code to fail, which causes functional regressions. I'm not sure how wide-
spread this issue is, but in testing on NVIDIA Tegra, I found two
instances that needed to be fixed. Perhaps  a failure of gpio_request
in the core IRQ code should trigger a WARN rather than returning an
error, to give a grace period for conversion of other code?

Stephen Warren (3):
  irq: If an IRQ is a GPIO, request and configure it
  mmc: tegra: Don't gpio_request GPIOs used as IRQs.
  ASoC: jack_add_gpios: Don't gpio_request GPIOs used as IRQs.

 drivers/mmc/host/sdhci-tegra.c |    8 --------
 kernel/irq/manage.c            |   25 +++++++++++++++++++++++--
 sound/soc/soc-jack.c           |   13 +------------
 3 files changed, 24 insertions(+), 22 deletions(-)
