From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 1/2] ARM: mmc: bcm281xx SDHCI driver
Date: Tue, 21 May 2013 20:23:03 +0200
Message-ID: <201305212023.03272.arnd@arndb.de>
References: <1368200883-15668-1-git-send-email-csd@broadcom.com> <201305170009.46244.arnd@arndb.de> <519B2EAD.4000208@broadcom.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <519B2EAD.4000208@broadcom.com>
Sender: linux-doc-owner@vger.kernel.org
To: Christian Daudt <csd@broadcom.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, csd_b@daudt.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 21 May 2013, Christian Daudt wrote:
> >> +    cfg = devm_kzalloc(&pdev->dev, sizeof(*cfg), GFP_KERNEL);
> >> +    if (!cfg) {
> >> +            dev_err(&pdev->dev, "Can't allocate platform cfg\n");
> >> +            return NULL;
> >> +    }
> > Not needed
> what is not needed ?

The allocation, it can be part of the sdhci_pltfm_host data.

> >> +    const struct sdhci_pltfm_data *plat_data;
> > make it global.
> why make this global ?

Sorry for being unclear. I mean you can just use &sdhci_pltfm_data_kona
in the probe function, since the data is constant anyway, no need to have
a local variable for pulling this out of the device id.

	Arnd
