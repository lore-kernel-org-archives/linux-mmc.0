From: Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: [next] Failing Odroid XU3 boot due to missing MMC device
Date: Thu, 14 Apr 2016 10:54:54 +0200
Message-ID: <570F5ADE.1010500@fivetechno.de>
References: <570F5380.7010103@samsung.com> <570F5550.5010708@fivetechno.de>
 <20160414084530.GS19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160414084530.GS19428@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Am 14.04.2016 um 10:45 schrieb Russell King - ARM Linux:
> On Thu, Apr 14, 2016 at 10:31:12AM +0200, Markus Reichl wrote:
>> Hi Krzysztof,
>>
>> yes, observed this with linux-next from yesterday 13.
>>
>> I boot from eMMC.
>> Device numbering of eMMC and SD are exchanged now.
>>
>> I solved the boot problem by changing the rootdev in U-Boot env
>> from /dev/mmcblk0p2 to /dev/mmcblk1p2.
>>
>> Changed /etc/fdisk, too, to mount /dev/mmcblk1p1 to /boot.     
> 
> You really should mount by partition uuid - supplying something like:
> 
> 	root=PARTUUID=f3ae567e-02
> 
> on the kernel command line.  This makes the mounting of rootfs
> independent of which device carries the filesystem.
> 
> If you're not using an initramfs, the kernel prints the partuuid
> values if it doesn't find the rootfs.  I don't know how to get the
> partuuids without going through that process, sorry.

lsblk --output PARTUUID

> 
