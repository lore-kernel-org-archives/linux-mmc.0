From: "Fernandes, Joel" <joelf-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
Date: Thu, 27 Jun 2013 18:10:48 +0000
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F0FAA@DLEE08.ent.ti.com>
References: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
	<CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
	<51CC2A1E.2040003@ti.com>
	<CAD=GYpa9LQ1fV6=O9B65sJURVAigsgXCPLWav8cHXTuGQXPc9A@mail.gmail.com>
	<51CC67CA.2070805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51CC67CA.2070805-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>Linux
List-Id: linux-mmc@vger.kernel.org

Adding Benoit's other email as current one is marked Away. Thanks.

> -----Original Message-----
> From: Krishnamoorthy, Balaji T
> Sent: Thursday, June 27, 2013 11:27 AM
> To: Cousson, Benoit; Fernandes, Joel
> Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org; Tony Lindgren; Nori, Sekhar; Matt Porter; Grant Likely;
> Rob Herring; Vinod Koul; Mark Brown; Russell King; Rob Landley; Andrew
> Morton; Jason Kridner; Koen Kooi; Chris Ball; Devicetree Discuss; Linux OMAP
> List; Linux ARM Kernel List; Linux DaVinci Kernel List; Linux Kernel Mailing List;
> Linux MMC List; Arnd Bergmann
> Subject: Re: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD
> data
> 
> On Thursday 27 June 2013 07:56 PM, Joel A Fernandes wrote:
> > Hi Benoit,
> >
> > On Thu, Jun 27, 2013 at 7:03 AM, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
> >> Hi Joel,
> >>
> >> On 06/26/2013 05:28 AM, Joel A Fernandes wrote:
> >>> On Tue, Jun 25, 2013 at 8:23 PM, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
> wrote:
> >>>> From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>>
> >>>> This series is fixes to get MMC working on AM33XX without HWMOD
> data.
> >>>> On removal of HWMOD data, interrupt and register properties need to
> >>>> be provided for the driver to function correctly.
> >>>
> >>> Please don't pull patches authored by me in this series. I have
> >>> posted them with my wrong email address by mistake. I will correct
> >>> my email during the next repost, after a round of review. Matt's
> >>> patches in the series are still good though.
> >>
> >> In that case, please repost these in two series to avoid pulling the
> >> DTS files in the MMC tree.
> >
> > The series has been replaced with the single patch:
> > "[PATCH v2] ARM: dts: add AM33XX MMC support"
> > http://marc.info/?l=linux-omap&m=137230403815943&w=2
> >
> > Some patches were squashed and others dropped in the series resulting
> > in the single patch above. This patch should be good to apply
> Hi Joel,
> 
> Before pushing mmc dts support for am335x, Can you please let me
> know if below 2 patches [1] are merged/accepted,
> IIRC these patches are needed for MMC to work properly.
> 
> I suggest to hold the dts patch until slave_sg_limit gets merged
> otherwise it will cause regression in am335x mmc.
> 
> [PATCH v4 1/3] dmaengine: add dma_get_slave_sg_limits()
> [PATCH v4 2/3] dma: edma: add device_slave_sg_limits() support
> 
> [1]
> https://groups.google.com/forum/#!topic/linux.kernel/khTTcPtQpag
> 
> >
> > Thanks,
> >
> > -Joel
> >
