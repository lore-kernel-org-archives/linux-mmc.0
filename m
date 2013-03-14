From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 0/4] Add DT support for davinci_mmc driver
Date: Thu, 14 Mar 2013 17:25:13 +0530
Message-ID: <5141BAA1.1070906@ti.com>
References: <1363097637-11371-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1363097637-11371-1-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: linux-mmc@vger.kernel.org

On 3/12/2013 7:43 PM, Manjunathappa, Prakash wrote:
> Patch set adds DT support for davinci_mmc driver and is
> verified on da850-evm without card_detect/write_protect and
> EDMA support. Also takecare to derive controller IP version from
> platform_device_id table, remove version specification in pdata.
> 
> Applies on top of below patch under community review:
> "Enable SPI flash support on da850-evm DT kernel"
> http://www.spinics.net/lists/arm-kernel/msg229328.html
> 
> Depends on patch waiting for acceptance:
> Patch "mmc: davinci: allow driver to work without DMA resource"
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg18771.html

Since this patch did not get picked for v3.9, it may be worthwhile
rebasing it and adding to this series.

Thanks,
Sekhar
