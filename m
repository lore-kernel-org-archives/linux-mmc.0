From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc:host:sdhci-pci:V2-Addition of Arasan PCI controller
 with integrated phy.
Date: Thu, 19 Oct 2017 14:53:20 +0300
Message-ID: <db8ff46e-755a-b09e-dae0-6416d380c188@intel.com>
References: <1507657369-2657-1-git-send-email-agarg@arasan.com>
 <22615e72-5260-e128-5dd6-510dfef46ac0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22615e72-5260-e128-5dd6-510dfef46ac0@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, nsekhar@ti.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 19/10/17 11:05, Adrian Hunter wrote:
> On 10/10/17 20:42, Atul Garg wrote:
> 
> Let's just put the declarations here:
> 
> int arasan_pci_probe_slot(struct sdhci_pci_slot *slot);
> int arasan_pci_probe(struct sdhci_pci_chip *chip);
> void arasan_sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> 

Actually checkpatch doesn't like that so let's put them in sdhci-pci.h
