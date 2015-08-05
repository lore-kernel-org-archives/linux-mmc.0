From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [SHDCI] Heavy (thousands) DMA leaks
Date: Wed, 5 Aug 2015 13:52:57 +0200
Message-ID: <55C1F919.4080002@suse.cz>
References: <55B9EF02.7040404@suse.cz>
 <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
 <55BF36D6.4080504@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060200090705080101010403"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BF36D6.4080504@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------060200090705080101010403
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 08/03/2015, 11:39 AM, Jiri Slaby wrote:
> Hi,
> 
> On 08/03/2015, 11:30 AM, Chen Bough wrote:
>> I carefully review my patch, all the DMA memory mapped in sdhci_pre_req() is unmapped in sdhci_post_req.
> 
> I suspect 'host_cookie' or 'next' handling is bad somewhere. But I don't
> know...
> 
>> Can you provide the method of your testing DMA leaks?
> 
> boot kernel with CONFIG_DMA_API_DEBUG
> insert the card
> mount it
> rsync from the card ~200 MB
> umount it
> unload the sdhci driver
> the leak warning is reported
> 
> I am not sure whether suspend-resume is needed after the first step.

No, it's not. This is sufficient:
boot kernel with CONFIG_DMA_API_DEBUG
insert the card
<no mounting, partition table read is enough>
remove the card
unload the sdhci driver
the leak warning is reported

>> You said over 4000 leaked mappings during one card transfer, if true, 
>> We can't map any dma memory after some sd transfer, do you meet this?
> 
> Yes, I see:
> sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 65536 bytes)
> after some time. The driver falls back to non-DMA transfers after that.
> It also generates a warning about that:
> WARNING: CPU: 0 PID: 0 at drivers/mmc/host/sdhci.c:857
> sdhci_prepare_data+0x8ec/0x900 [sdhci]()

I am attaching a debug patch and a debug log. You can see where
0x00000000fffb0000 and 0x00000000fffe0000 is leaked. It is when 'invalid
cookie' error happens.

regards,
-- 
js
suse labs

--------------060200090705080101010403
Content-Type: text/plain; charset=UTF-8;
 name="bad_dma"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bad_dma"

[  474.663337] sdhci_pre_dma_transfer: mapped ffff88030bfe7bc0 0x00000000fffff3f0 (wanted=1, got=1), next=          (null), hcook=0, ncook=1
[  474.663844] sdhci_finish_data: unmapping ffff88030bfe7bc0 phys=0x00000000fffff3f0 size=1
[  474.664109] sdhci_pre_dma_transfer: mapped ffff88030bfe7bc0 0x00000000ffffe310 (wanted=1, got=1), next=          (null), hcook=0, ncook=1
[  474.665025] sdhci_finish_data: unmapping ffff88030bfe7bc0 phys=0x00000000ffffe310 size=1
[  474.665136] sdhci_pre_dma_transfer: mapped ffff88030bfe7bd0 0x00000000ffffd310 (wanted=1, got=1), next=          (null), hcook=0, ncook=1
[  474.666746] sdhci_finish_data: unmapping ffff88030bfe7bd0 phys=0x00000000ffffd310 size=1
[  474.666912] sdhci_pre_dma_transfer: mapped ffff88030bfe7be0 0x00000000ffffc310 (wanted=1, got=1), next=          (null), hcook=0, ncook=1
[  474.669979] sdhci_finish_data: unmapping ffff88030bfe7be0 phys=0x00000000ffffc310 size=1
[  474.670405] mmc0: new high speed SDHC card at address e624
[  474.671107] mmcblk0: mmc0:e624 SU16G 14.8 GiB 
[  474.672309] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=1
[  474.682178] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffb000 size=1
[  474.682234]  mmcblk0: p1
[  474.684064] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=2
[  474.684825] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffff000 size=1
[  474.684954] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=3
[  474.685494] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffe000 size=1
[  474.685660] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=4
[  474.686316] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffd000 size=1
[  474.686449] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=5
[  474.686878] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffc000 size=1
[  474.687046] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=6
[  474.687590] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffa000 size=1
[  474.687720] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=7
[  474.688203] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff9000 size=1
[  474.688342] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=8
[  474.688865] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff8000 size=1
[  474.688988] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff7000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=9
[  474.689618] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff7000 size=1
[  474.689748] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff6000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=10
[  474.690393] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff6000 size=1
[  474.690549] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff5000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=11
[  474.691165] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff5000 size=1
[  474.691289] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff4000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=12
[  474.691927] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff4000 size=1
[  474.692066] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff3000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=13
[  474.692690] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff3000 size=1
[  474.692826] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff2000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=14
[  474.693450] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff2000 size=1
[  474.693548] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff1000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=15
[  474.694151] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff1000 size=1
[  474.694304] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=16
[  474.694915] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffff000 size=1
[  474.695047] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=17
[  474.695692] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffe000 size=1
[  474.695843] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=18
[  474.696270] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffd000 size=1
[  474.696406] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=19
[  474.696836] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffc000 size=1
[  474.696995] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=20
[  474.697420] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffb000 size=1
[  474.697543] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=21
[  474.697967] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffa000 size=1
[  474.698173] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=22
[  474.698606] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff9000 size=1
[  474.698851] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffe0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=23
[  474.698875] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffd0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=24
[  474.698879] sdhci[sdhci_pre_dma_transfer] invalid cookie: 24, next-cookie 25
[  474.698891] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffc0000 (wanted=1, got=1), next=          (null), hcook=0, ncook=25
[  474.700577] sdhci_finish_data: unmapping ffff880306c52e10 phys=0x00000000fffc0000 size=1
[  474.700694] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffb0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=25
[  474.702431] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffd0000 size=1
[  474.702486] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffa8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=26
[  474.704192] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffb0000 size=1
[  474.704247] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffa4000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=27
[  474.705157] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffa8000 size=1
[  474.705217] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffa3000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=28
[  474.705756] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffa4000 size=1
[  474.706161] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffa3000 size=1
[  474.706339] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=29
[  474.706869] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffff000 size=1
[  474.707025] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=30
[  474.707543] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffe000 size=1
[  474.707676] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=31
[  474.708196] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffd000 size=1
[  474.708338] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=32
[  474.708801] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffc000 size=1
[  474.708916] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=33
[  474.709359] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffb000 size=1
[  474.709513] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=34
[  474.710003] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffa000 size=1
[  474.710378] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=35
[  474.710879] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff9000 size=1
[  474.710985] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=36
[  474.711449] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff8000 size=1
[  474.711572] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff7000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=37
[  474.712051] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff7000 size=1
[  474.712139] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff6000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=38
[  474.712617] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff6000 size=1
[  474.712704] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff5000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=39
[  474.713151] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff5000 size=1
[  474.713221] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff4000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=40
[  474.713666] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff4000 size=1
[  474.713732] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff3000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=41
[  474.714177] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff3000 size=1
[  474.714248] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff2000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=42
[  474.714704] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff2000 size=1
[  474.714832] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff1000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=43
[  474.715296] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff1000 size=1
[  474.715416] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=44
[  474.715867] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff0000 size=1
[  474.715991] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffdf000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=45
[  474.716437] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffdf000 size=1
[  474.716538] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffde000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=46
[  474.716983] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffde000 size=1
[  474.717093] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffdd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=47
[  474.717556] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffdd000 size=1
[  474.717667] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffdc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=48
[  474.718121] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffdc000 size=1
[  474.718278] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=49
[  474.718722] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffff000 size=1
[  474.718787] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=50
[  474.719229] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffe000 size=1
[  474.719293] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=51
[  474.719734] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffd000 size=1
[  474.719797] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=52
[  474.720239] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffc000 size=1
[  474.720301] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=53
[  474.720741] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffb000 size=1
[  474.720804] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=54
[  474.721245] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffa000 size=1
[  474.721311] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=55
[  474.721754] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff9000 size=1
[  474.721816] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=56
[  474.722261] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff8000 size=1
[  474.722465] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff7000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=57
[  474.722925] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff7000 size=1
[  474.723047] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff6000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=58
[  474.723511] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff6000 size=1
[  474.723621] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff5000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=59
[  474.724067] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff5000 size=1
[  474.724140] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff4000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=60
[  474.724583] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff4000 size=1
[  474.724696] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff3000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=61
[  474.725144] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff3000 size=1
[  474.725223] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff2000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=62
[  474.725680] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff2000 size=1
[  474.736023] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=63
[  474.736711] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffff000 size=1
[  474.736853] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=64
[  474.737405] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffe000 size=1
[  474.737502] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=65
[  474.738523] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffd000 size=1
[  474.738653] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=66
[  474.739355] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffc000 size=1
[  474.739498] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=67
[  474.740055] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffb000 size=1
[  474.740169] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=68
[  474.740679] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffffa000 size=1
[  474.740817] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=69
[  474.747111] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff9000 size=1
[  474.747361] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=70
[  474.761987] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff0000 size=1
[  474.762816] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffd0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=71
[  474.767029] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffd0000 size=1
[  474.767181] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffcf000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=72
[  474.767645] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffcf000 size=1
[  474.767777] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffce000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=73
[  474.768244] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffce000 size=1
[  474.768408] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffcd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=74
[  474.768857] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffcd000 size=1
[  474.769387] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffb0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=75
[  474.769444] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffa0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=76
[  474.769449] sdhci[sdhci_pre_dma_transfer] invalid cookie: 76, next-cookie 77
[  474.769464] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fff90000 (wanted=1, got=1), next=          (null), hcook=0, ncook=77
[  474.771224] sdhci_finish_data: unmapping ffff880306dda438 phys=0x00000000fff90000 size=1
[  474.771421] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000ffff0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=77
[  474.773219] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffa0000 size=1
[  474.773315] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffd8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=78
[  474.775004] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000ffff0000 size=1
[  474.775094] sdhci_pre_dma_transfer: mapped ffff880306dda438 0x00000000fffd4000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=79
[  474.775962] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffd8000 size=1
[  474.776020] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffd3000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=80
[  474.776568] sdhci_post_req: unmapping ffff880306dda438 phys=0x00000000fffd4000 size=1
[  474.776976] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffd3000 size=1
[  474.777183] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffd2000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=81
[  474.777759] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffd2000 size=1
[  474.777883] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffd1000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=82
[  474.778469] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffd1000 size=1
[  474.778637] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffd0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=83
[  474.779233] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffd0000 size=1
[  474.779402] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffcf000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=84
[  474.780032] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffcf000 size=1
[  474.780217] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffce000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=85
[  474.780802] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffce000 size=1
[  474.780944] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffcd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=86
[  474.781493] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffcd000 size=1
[  474.781632] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffcc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=87
[  474.782201] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffcc000 size=1
[  474.782356] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=88
[  474.782963] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffff000 size=1
[  474.783094] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=89
[  474.783695] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffe000 size=1
[  474.783800] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=90
[  474.784402] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffd000 size=1
[  474.784518] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=91
[  474.785057] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffc000 size=1
[  474.785160] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=92
[  474.785716] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffb000 size=1
[  474.785840] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=93
[  474.786418] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffa000 size=1
[  474.786551] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=94
[  474.787125] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff9000 size=1
[  474.787249] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=95
[  474.787805] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff8000 size=1
[  474.787907] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff7000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=96
[  474.788452] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff7000 size=1
[  474.788564] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff6000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=97
[  474.789333] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff6000 size=1
[  474.789426] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff5000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=98
[  474.789947] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff5000 size=1
[  474.790061] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff4000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=99
[  474.790604] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff4000 size=1
[  474.790727] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff3000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=100
[  474.791263] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff3000 size=1
[  474.791389] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff2000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=101
[  474.791922] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff2000 size=1
[  474.792040] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff1000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=102
[  474.792556] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff1000 size=1
[  474.792711] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff0000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=103
[  474.793231] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff0000 size=1
[  474.793326] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffdf000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=104
[  474.793848] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffdf000 size=1
[  474.793964] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffde000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=105
[  474.794502] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffde000 size=1
[  474.794626] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000fffff000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=106
[  474.795162] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000fffff000 size=1
[  474.795285] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffe000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=107
[  474.795824] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffe000 size=1
[  474.795941] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffd000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=108
[  474.796456] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffd000 size=1
[  474.796559] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffc000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=109
[  474.797076] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffc000 size=1
[  474.797180] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffb000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=110
[  474.797962] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffb000 size=1
[  474.798080] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffffa000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=111
[  474.798671] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffffa000 size=1
[  474.798796] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff9000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=112
[  474.799354] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff9000 size=1
[  474.799482] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff8000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=113
[  474.799943] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff8000 size=1
[  474.800063] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff7000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=114
[  474.800527] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff7000 size=1
[  474.800856] sdhci_pre_dma_transfer: mapped ffff880306c52e10 0x00000000ffff6000 (wanted=1, got=1), next=ffff88030bf21aa4, hcook=0, ncook=115
[  474.801523] sdhci_post_req: unmapping ffff880306c52e10 phys=0x00000000ffff6000 size=1
[  537.183193] mmc0: card e624 removed
[  539.324181] ------------[ cut here ]------------
[  539.324189] WARNING: CPU: 2 PID: 1193 at lib/dma-debug.c:974 dma_debug_device_change+0x158/0x1c0()
[  539.324192] pci 0000:02:00.0: DMA-API: device driver has pending DMA allocations while released from device [count=2]
               One of leaked entries details: [device address=0x00000000fffe0000] [size=65536 bytes] [mapped with DMA_FROM_DEVICE] [mapped as scather-gather]
[  539.324194] Modules linked in:
[  539.324198] CPU: 2 PID: 1193 Comm: bash Not tainted 4.2.0-rc4+ #20
[  539.324199] Hardware name: LENOVO 23252SG/23252SG, BIOS G2ET33WW (1.13 ) 07/24/2012
[  539.324201]  ffffffff81cc5faa ffff8800d6bfbb68 ffffffff81820998 0000000000000000
[  539.324204]  ffff8800d6bfbbb8 ffff8800d6bfbba8 ffffffff810b827a 0000000100260024
[  539.324206]  ffff88030e500000 0000000000000002 ffff88030df3f0c0 ffff88030e4ddd68
[  539.324209] Call Trace:
[  539.324213]  [<ffffffff81820998>] dump_stack+0x4c/0x6e
[  539.324217]  [<ffffffff810b827a>] warn_slowpath_common+0x8a/0xc0
[  539.324219]  [<ffffffff810b82f6>] warn_slowpath_fmt+0x46/0x50
[  539.324222]  [<ffffffff813248c8>] dma_debug_device_change+0x158/0x1c0
[  539.324226]  [<ffffffff810d4e9d>] notifier_call_chain+0x4d/0x80
[  539.324250]  [<ffffffff810d51fd>] __blocking_notifier_call_chain+0x4d/0x70
[  539.324253]  [<ffffffff810d5236>] blocking_notifier_call_chain+0x16/0x20
[  539.324256]  [<ffffffff814db395>] __device_release_driver+0x105/0x130
[  539.324258]  [<ffffffff814db3e3>] device_release_driver+0x23/0x30
[  539.324262]  [<ffffffff814d95ca>] unbind_store+0xba/0xe0
[  539.324266]  [<ffffffff8123c638>] ? kernfs_fop_write+0xe8/0x170
[  539.324269]  [<ffffffff814d8ac4>] drv_attr_store+0x24/0x30
[  539.324276]  [<ffffffff8123ce4a>] sysfs_kf_write+0x3a/0x50
[  539.324284]  [<ffffffff8123c670>] kernfs_fop_write+0x120/0x170
[  539.324290]  [<ffffffff811ce9e8>] __vfs_write+0x28/0xe0
[  539.324296]  [<ffffffff811d1209>] ? __sb_start_write+0x49/0xe0
[  539.324302]  [<ffffffff810e3ba5>] ? local_clock+0x25/0x30
[  539.324306]  [<ffffffff810e3d76>] ? get_vtime_delta+0x16/0x80
[  539.324311]  [<ffffffff811cf041>] vfs_write+0xa1/0x170
[  539.324316]  [<ffffffff810e43c4>] ? vtime_account_user+0x54/0x60
[  539.324319]  [<ffffffff811cfce6>] SyS_write+0x46/0xa0
[  539.324322]  [<ffffffff81180f83>] ? context_tracking_user_exit+0x13/0x20
[  539.324326]  [<ffffffff8182a117>] entry_SYSCALL_64_fastpath+0x12/0x6a
[  539.324329] ---[ end trace 08b1aea46b9d093b ]---
[  539.324330] Mapped at:
[  539.324332]  [<ffffffff81324492>] debug_dma_map_sg+0x122/0x140
[  539.324335]  [<ffffffff81616f60>] sdhci_pre_dma_transfer+0xe0/0x1f0
[  539.324338]  [<ffffffff816170b2>] sdhci_pre_req+0x42/0x70
[  539.324340]  [<ffffffff81601572>] mmc_pre_req+0x42/0x60
[  539.324345]  [<ffffffff816029ee>] mmc_start_req+0x3e/0x400

--------------060200090705080101010403
Content-Type: application/mbox;
 name="debug.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="debug.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2kuYwppbmRleCAxZGJlOTMyMzIwMzAuLjJkY2I2YzE4YTE2ZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuYwpAQCAtNjM1LDkgKzYzNSwxMSBAQCBzdGF0aWMgdm9pZCBzZGhjaV9hZG1hX3RhYmxl
X3Bvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsCiAJCX0KIAl9CiAKLQlpZiAoIWRhdGEt
Pmhvc3RfY29va2llKQorCWlmICghZGF0YS0+aG9zdF9jb29raWUpIHsKKwkJcHJfaW5mbygi
JXM6IHVubWFwcGluZyAlcCBwaHlzPSVwYWQgc2l6ZT0ldVxuIiwgX19mdW5jX18sIGRhdGEt
PnNnLCAmc2dfZG1hX2FkZHJlc3MoZGF0YS0+c2cpLCBkYXRhLT5zZ19sZW4pOwogCQlkbWFf
dW5tYXBfc2cobW1jX2Rldihob3N0LT5tbWMpLCBkYXRhLT5zZywKIAkJCWRhdGEtPnNnX2xl
biwgZGlyZWN0aW9uKTsKKwl9CiB9CiAKIHN0YXRpYyB1OCBzZGhjaV9jYWxjX3RpbWVvdXQo
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfY29tbWFuZCAqY21kKQpAQCAt
OTQ5LDExICs5NTEsMTMgQEAgc3RhdGljIHZvaWQgc2RoY2lfZmluaXNoX2RhdGEoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QpCiAJCWlmIChob3N0LT5mbGFncyAmIFNESENJX1VTRV9BRE1B
KQogCQkJc2RoY2lfYWRtYV90YWJsZV9wb3N0KGhvc3QsIGRhdGEpOwogCQllbHNlIHsKLQkJ
CWlmICghZGF0YS0+aG9zdF9jb29raWUpCisJCQlpZiAoIWRhdGEtPmhvc3RfY29va2llKSB7
CisJCQkJcHJfaW5mbygiJXM6IHVubWFwcGluZyAlcCBwaHlzPSVwYWQgc2l6ZT0ldVxuIiwg
X19mdW5jX18sIGRhdGEtPnNnLCAmc2dfZG1hX2FkZHJlc3MoZGF0YS0+c2cpLCBkYXRhLT5z
Z19sZW4pOwogCQkJCWRtYV91bm1hcF9zZyhtbWNfZGV2KGhvc3QtPm1tYyksCiAJCQkJCWRh
dGEtPnNnLCBkYXRhLT5zZ19sZW4sCiAJCQkJCShkYXRhLT5mbGFncyAmIE1NQ19EQVRBX1JF
QUQpID8KIAkJCQkJRE1BX0ZST01fREVWSUNFIDogRE1BX1RPX0RFVklDRSk7CisJCQl9CiAJ
CX0KIAl9CiAKQEAgLTIwOTcsMTAgKzIxMDEsMTIgQEAgc3RhdGljIHZvaWQgc2RoY2lfcG9z
dF9yZXEoc3RydWN0IG1tY19ob3N0ICptbWMsIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJxLAog
CXN0cnVjdCBtbWNfZGF0YSAqZGF0YSA9IG1ycS0+ZGF0YTsKIAogCWlmIChob3N0LT5mbGFn
cyAmIFNESENJX1JFUV9VU0VfRE1BKSB7Ci0JCWlmIChkYXRhLT5ob3N0X2Nvb2tpZSkKKwkJ
aWYgKGRhdGEtPmhvc3RfY29va2llKSB7CisJCQlwcl9pbmZvKCIlczogdW5tYXBwaW5nICVw
IHBoeXM9JXBhZCBzaXplPSV1XG4iLCBfX2Z1bmNfXywgZGF0YS0+c2csICZzZ19kbWFfYWRk
cmVzcyhkYXRhLT5zZyksIGRhdGEtPnNnX2xlbik7CiAJCQlkbWFfdW5tYXBfc2cobW1jX2Rl
dihob3N0LT5tbWMpLCBkYXRhLT5zZywgZGF0YS0+c2dfbGVuLAogCQkJCQkgZGF0YS0+Zmxh
Z3MgJiBNTUNfREFUQV9XUklURSA/CiAJCQkJCSBETUFfVE9fREVWSUNFIDogRE1BX0ZST01f
REVWSUNFKTsKKwkJfQogCQltcnEtPmRhdGEtPmhvc3RfY29va2llID0gMDsKIAl9CiB9CkBA
IC0yMTEzLDcgKzIxMTksNyBAQCBzdGF0aWMgaW50IHNkaGNpX3ByZV9kbWFfdHJhbnNmZXIo
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsCiAKIAlpZiAoIW5leHQgJiYgZGF0YS0+aG9zdF9j
b29raWUgJiYKIAkgICAgZGF0YS0+aG9zdF9jb29raWUgIT0gaG9zdC0+bmV4dF9kYXRhLmNv
b2tpZSkgewotCQlwcl9kZWJ1ZyhEUklWRVJfTkFNRSAiWyVzXSBpbnZhbGlkIGNvb2tpZTog
JWQsIG5leHQtY29va2llICVkXG4iLAorCQlwcl9pbmZvKERSSVZFUl9OQU1FICJbJXNdIGlu
dmFsaWQgY29va2llOiAlZCwgbmV4dC1jb29raWUgJWRcbiIsCiAJCQlfX2Z1bmNfXywgZGF0
YS0+aG9zdF9jb29raWUsIGhvc3QtPm5leHRfZGF0YS5jb29raWUpOwogCQlkYXRhLT5ob3N0
X2Nvb2tpZSA9IDA7CiAJfQpAQCAtMjEyNSw2ICsyMTMxLDkgQEAgc3RhdGljIGludCBzZGhj
aV9wcmVfZG1hX3RyYW5zZmVyKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAogCQkJCSAgICAg
ZGF0YS0+c2dfbGVuLAogCQkJCSAgICAgZGF0YS0+ZmxhZ3MgJiBNTUNfREFUQV9XUklURSA/
CiAJCQkJICAgICBETUFfVE9fREVWSUNFIDogRE1BX0ZST01fREVWSUNFKTsKKwkJcHJfaW5m
bygiJXM6IG1hcHBlZCAlcCAlcGFkICh3YW50ZWQ9JXUsIGdvdD0lZCksIG5leHQ9JXAsIGhj
b29rPSVkLCBuY29vaz0lZFxuIiwKKwkJCQlfX2Z1bmNfXywgZGF0YS0+c2csICZzZ19kbWFf
YWRkcmVzcyhkYXRhLT5zZyksIGRhdGEtPnNnX2xlbiwgc2dfY291bnQsIG5leHQsIGRhdGEt
Pmhvc3RfY29va2llLAorCQkJCWhvc3QtPm5leHRfZGF0YS5jb29raWUpOwogCiAJfSBlbHNl
IHsKIAkJc2dfY291bnQgPSBob3N0LT5uZXh0X2RhdGEuc2dfY291bnQ7Cg==
--------------060200090705080101010403--
