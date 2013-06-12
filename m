From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 01/10] ARM: OMAP2+: add needs_vmmc to hsmmc_info
Date: Wed, 12 Jun 2013 22:30:08 +0530
Message-ID: <51B8A918.5030605@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-2-git-send-email-balajitk@ti.com>
 <20130612142409.GW8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130612142409.GW8164-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 12 June 2013 07:54 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk-l0cyMroinI0@public.gmane.org> [130606 12:20]:
>> Add needs_vmmc and needs_vmmc_aux to indicate whether regulator is
>> applicable so that omap_hsmmc can handle deferred probe error
>> properly for regulators.
>> Remove the assumption that vmmc_aux regulator to be available only if vmmc is
>> present. Platforms can have fixed-always-ON regulator for vmmc and/or vmmc_aux
>> in such cases regulator needed not be specified in board file.
>
> Looks good to me, I suggest you resend this again a bit later once the
> other changes are merged so we can avoid a dependency between arch/arm/mach-omap2
> and MMC changes.
>

Ok, will separate the board changes and send the rest via mmc tree

> Regards,
>
> Tony
>
>> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/mach-omap2/board-2430sdp.c          |    1 +
>>   arch/arm/mach-omap2/board-3430sdp.c          |    3 +++
>>   arch/arm/mach-omap2/board-cm-t35.c           |    2 ++
>>   arch/arm/mach-omap2/board-devkit8000.c       |    1 +
>>   arch/arm/mach-omap2/board-igep0020.c         |    3 +++
>>   arch/arm/mach-omap2/board-ldp.c              |    1 +
>>   arch/arm/mach-omap2/board-omap3beagle.c      |    2 ++
>>   arch/arm/mach-omap2/board-omap3evm.c         |    3 +++
>>   arch/arm/mach-omap2/board-omap3logic.c       |    1 +
>>   arch/arm/mach-omap2/board-omap3pandora.c     |    3 +++
>>   arch/arm/mach-omap2/board-omap3stalker.c     |    2 ++
>>   arch/arm/mach-omap2/board-omap3touchbook.c   |    2 ++
>>   arch/arm/mach-omap2/board-overo.c            |    1 +
>>   arch/arm/mach-omap2/board-rm680.c            |    1 +
>>   arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
>>   arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++++
>>   arch/arm/mach-omap2/hsmmc.c                  |    2 ++
>>   arch/arm/mach-omap2/hsmmc.h                  |    2 ++
>>   include/linux/platform_data/mmc-omap.h       |    2 ++
>>   19 files changed, 39 insertions(+), 0 deletions(-)
>>
