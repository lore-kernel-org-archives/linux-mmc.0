From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] omap_hsmmc DT DMA Client support
Date: Mon, 17 Jun 2013 21:14:47 +0530
Message-ID: <51BF2EEF.8070209@ti.com>
References: <1362518004-7083-1-git-send-email-mporter@ti.com>
 <201303052126.01572.arnd@arndb.de> <20130306133717.GJ6209@beef>
 <CAD=GYpbmFyZxwpRwSVjasehhmR5UzMQaGCZf_5Gfo9biQyb0Ww@mail.gmail.com>
 <CAD=GYpaSMkTCWgetPxvchuZMWzzB09_F3nqazKFRJob1imoXUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=GYpaSMkTCWgetPxvchuZMWzzB09_F3nqazKFRJob1imoXUw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Friday 14 June 2013 11:40 PM, Joel A Fernandes wrote:
> Resending on Matt's new email, thanks.
>
> On Fri, Jun 14, 2013 at 1:10 PM, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi,
>>
>> On Wed, Mar 6, 2013 at 7:37 AM, Matt Porter <mporter-l0cyMroinI0@public.gmane.org> wrote:
>>> On Tue, Mar 05, 2013 at 09:26:01PM +0000, Arnd Bergmann wrote:
>>>> On Tuesday 05 March 2013, Matt Porter wrote:
>>>>> Changes since v1:
>>>>>          - rebase to 3.9-rc1, previous dependencies upstream
>>>>>
>>>>> This series adds DT DMA Engine Client support to the omap_hsmmc.
>>>>> It leverages the generic DMA OF helpers in -next and the
>>>>> dma_request_slave_channel_compat() wrapper introduced in the
>>>>> AM33XX DMA Engine series to support DMA in omap_hsmmc on platforms
>>>>> booting via DT. These platforms include omap2/3/4/5 and am33xx.
>>>>>
>>>>> These patches were split out from the v5 version of the AM33XX DMA
>>>>> series and split from the EDMA-specific omap_hsmmc changes.
>>>>>
>>>>
>>>> The description seems stale, but the patches all look good to me.
>>>>
>>>> I guess they can now get merged in any order.
>>>>
>>>> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>>
>>> Yes, missed updating that to indicating that those are now in
>>> 3.9-rc1.
>>
>> If there are no more changes, could this patch please be merged in for
>> 3.10 or if not, could Matt please update the description as requested
>> and repost?
>>
Hi Joel,

   mmc: omap_hsmmc: Skip platform_get_resource_byname() for dt case
   mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()
got merged in 3.10 rc5

   mmc: omap_hsmmc: add generic DMA request support to the DT binding
should go along with edma dts patch series

>> Thanks,
>> Joel
