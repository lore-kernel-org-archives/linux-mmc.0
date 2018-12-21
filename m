From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Dec 21 (mmc/host/sdhci-omap.c)
Date: Fri, 21 Dec 2018 09:35:56 -0800
Message-ID: <16ca363b-92a7-d1cd-8460-21514e0e964b@infradead.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221193244.3a6ed685@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 12/21/18 12:32 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release until Jan 2.  Have a good break.
> 
> Changes since 20181220:
> 

on x86_64:

This change to drivers/mmc/host/Kconfig:

 config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
 	depends on MMC_SDHCI_PLTFM && OF
+	select THERMAL
+	select TI_SOC_THERMAL

causes a Kconfig warning:

WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
  Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
  Selected by [m]:
  - MMC_SDHCI_OMAP [=m] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]


because ARCH_HAS_BANDGAP is not set (nor is COMPILE_TEST).


-- 
~Randy
