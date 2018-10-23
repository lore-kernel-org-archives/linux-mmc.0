From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 0/3] sdhci-pci voltage switch fixes
Date: Tue, 23 Oct 2018 12:07:26 +0200
Message-ID: <20181023100729.28864-1-anisse@astier.eu>
References: <20181022134026.GB18413@jaya> <20181018102112.31054-1-anisse@astier.eu> <88d3fffb-df8d-f29e-f7c1-3bef815435d2@intel.com> <20181019092513.GA2150@jaya> <89d02cd8-c910-76fe-3b08-5dd056ba8a11@intel.com> <20181019134237.GA2762@jaya> <e329ed2e-75b5-e9f0-04e8-097594003e66@intel.com> <20181022091436.GA18413@jaya> <656f1d2e-e27a-cee4-78e1-774e45f067a6@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
List-Id: linux-mmc@vger.kernel.org

Hi,

This new patch series changes the approach to enabling the no-1.8V
quirk. We determined that not having the DSM method might not be a good
enough signal for the board/eMMC not supporting 1.8V.

It now uses a DMI quirk; I've also added another machine which benefited
from the previous patch, but for which the issue is harder to reproduce.

I've kept the previous cleanup of the voltage_switch callback in an
optional third patch, but it does not enable any quirk.

Anisse Astier (3):
  mmc: sdhci-pci: disable 1.8V with dmi quirk
  mmc: sdhci-pci: add new machine with 1.8V dmi quirk
  mmc: sdhci-pci: only install voltage switch method when useful

 drivers/mmc/host/sdhci-pci-core.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.17.2
