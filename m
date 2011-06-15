From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: sdhci-pci fails on 3.0.0-rc1 on Dell E6510
Date: Wed, 15 Jun 2011 11:31:16 -0700
Message-ID: <BANLkTi=2rricbvxhMNBrPQihxautTUvspQ@mail.gmail.com>
References: <4DEBCA3F.8050205@hartkopp.net> <BANLkTin_WHuy5MExNBHdeLiDmdmn7SZYkg@mail.gmail.com>
 <4DED05C4.7050903@hartkopp.net> <m3hb82wx6m.fsf@pullcord.laptop.org>
 <4DEE6FC6.9040308@hartkopp.net> <4DEE84AD.6050104@hartkopp.net>
 <4DEEA3CD.30507@kernel.org> <4DEF1606.5030803@hartkopp.net> <20110612204406.GC30738@ram-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110612204406.GC30738@ram-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Yinghai Lu <yinghai@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Ball <cjb@laptop.org>, "S, Venkatraman" <svenkatr@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Jun 12, 2011 at 1:44 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> Looks like the kernel; by default, tries to allocate mem resource of size
> 0x4000000 each to the BARs of the cardbus bridge. This cannot be satisfied
> meeting all the constraints. The BIOS had not allocated the resource to
> begin with.
>
> Anyone knows if the default value can be reduced to something smaller?

You can try "pci=cbmemsize=" as a workaround.  See pci_cardbus_mem_size.
