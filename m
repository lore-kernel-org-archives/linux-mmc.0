From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Sat, 16 Apr 2011 01:43:00 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB444355@SAUSEXMBP01.amd.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
 <BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
 <000001cbfbfd$efa6e120$cef4a360$@org>
 <6C03668EAF45B747AF947A1603D1B300EB444353@SAUSEXMBP01.amd.com>
 <001601cbfc00$b87eac20$297c0460$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:17835
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751453Ab1DPGnL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Apr 2011 02:43:11 -0400
In-Reply-To: <001601cbfc00$b87eac20$297c0460$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, 'Andrei Warkentin' <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> -----Original Message-----
> From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
> Sent: Saturday, April 16, 2011 12:07 PM
> To: Nath, Arindam; 'Andrei Warkentin'; linux-mmc@vger.kernel.org
> Subject: RE: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
> 
> 
> 
> > -----Original Message-----
> > From: Nath, Arindam [mailto:Arindam.Nath@amd.com]
> > Sent: Saturday, April 16, 2011 11:56 AM
> > To: Subhash Jadavani; 'Andrei Warkentin'; linux-mmc@vger.kernel.org
> > Subject: RE: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
> >
> > Hi Subhash,
> >
> >
> > > -----Original Message-----
> > > From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
> > > Sent: Saturday, April 16, 2011 11:47 AM
> > > To: 'Andrei Warkentin'; Nath, Arindam; linux-mmc@vger.kernel.org
> > > Subject: RE: [PATCH v3 01/12] mmc: sdhci: add support for auto
> CMD23
> > >
> > > > -----Original Message-----
> > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > owner@vger.kernel.org] On Behalf Of Andrei Warkentin
> > > > Sent: Saturday, April 16, 2011 1:34 AM
> > > > To: Nath, Arindam; linux-mmc@vger.kernel.org
> > > > Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto
> > CMD23
> > > >
> > > > +linux-mmc
> > > >
> > > > On Fri, Apr 15, 2011 at 3:03 PM, Andrei Warkentin
> > > > <andreiw@motorola.com> wrote:
> > > > > On Fri, Apr 15, 2011 at 1:57 PM, Andrei Warkentin
> > > > <andreiw@motorola.com> wrote:
> > > > >> Hi Arindam,
> > > > >>
> > > > >> On Fri, Apr 15, 2011 at 12:34 PM, Nath, Arindam
> > > > <Arindam.Nath@amd.com> wrote:
> > > > >>> Hi Andrei,
> > > > >>
> > > > >>>>
> > > > >>>> I've recently posted changes relating to CMD23 support in
> > block
> > > > layer.
> > > > >>>> Effectively, in order to support hosts with and without
> > > > >>>> Auto-CMD23 (and with proper error handling) there is a new
> > > > >>>> MMC_CAP_CMD23 for
> > > > the
> > > > >>>> host, and a new field "mmc_command sbc" inside the
> > mmc_request.
> > > > >>>>
> > > > >>>> I also have a patch enabling CMD23 use with an SDHCI host (<
> > > > 3.00).
> > > > >>>>
> > > > >>>> Could you be so kind as to rebase this patch on top of that?
> > > > You're
> > > > >>>> doing a lot of things here that you really shouldn't be
> (like
> > > > >>>> enforcing policy on what gets sent to cards, knowing what's
> > > > connected
> > > > >>>> to the host, conflicting with reliable writes code if Auto-
> > CMD23
> > > > was
> > > > >>>> enabled for MMCs, not supporting MMCs which always have
> > > > >>>> SET_BLOCK_COUNT).
> > > > >>>
> > > > >>> Our Host Controller is complaint to the Host Controller Spec
> > > > >>> v3.00,
> > > > and since Auto CMD23 is a feature added to the HC, I thought it
> > would
> > > > be better to make this feature part of sdhci and not the
> core/block
> > > > layer.
> > > > >>>
> > > > >>> But in case you want Auto CMD23 to be implemented in a
> > different
> > > > way, it would rather be great if you help me implement in your
> own
> > > > way, and then probably based on community suggestions, we can
> keep
> > > > either of the patch.
> > > > >>
> > > > >> Let me clarify:
> > > > >>
> > > > >> 1) Sending CMD23 on multiblock transfers is not a an SDHCI
> > > specific
> > > > >> feature. It's a feature of MMC cards and SD cards operating at
> > > > UHS104
> > > > >> or greater.
> > > > >> 2) CMD23-bounded multi block writes are a generic problem
> > already
> > > -
> > > > >> eMMC reliable writes, for example.
> > > > >> 3) CMD23 is not bound to any specific controller - so having
> > > > >> generic code to allow execution of CMD23 will speed up
> transfers
> > > > >> (and enable certain features) on any host.
> > >
> > > These are the same point I had discussed earlier with Arindam.
> Please
> > > check the attached mails.
> > >
> > > Yes, I would also agree with Andrei that all generic code related
> to
> > > CMD23 handling should be in core/block layer. Internally host
> > > controller driver can handle CMD23 differently as not all host
> > > controller support AUTO-CMD23.
> >
> > Please keep in mind that my patch _only_ adds support for Auto CMD23,
> > and not CMD23. CMD23 support can be made part of block layer, but
> Auto
> > CMD23 is a feature as per the Host Controller Spec v3.00. So my patch
> > takes care of the second case.
> 
> Agreed. But point is that Host controller driver should not be sending
> CMD23
> to card unless indicated by core/block layer to do so. In your patch
> you are
> checking in host controller driver that SD card supports CMD23 or not
> and
> then sending the CMD23 for multi block read/write. MMC cards also
> supports
> CMD23 so in that case again you have to check MMC EXT_CSD register for
> CMD23

Yes, you are right. I followed the Physical Layer Spec v3.01 as is, so in case the support is needed for MMC cards, we will need to take care of that too.

> support. All this logic is better be in core/block layer and let
> core/block
> layer inform host controller when to send CMD23 and when not to.

Well in that case, Auto CMD23 will never make sense.

Thanks,
Arindam

> 
> >
> > Thanks,
> > Arindam
> >
> > >
> > > > >> 4) Auto-CMD is a specific SDHCI enhancement, meant to reduce
> > > > overhead
> > > > >> of sending CMD23.
> > > > >> 5) Host controller has to be aware of CMD23 sending, because
> on
> > an
> > > > >> error STOP has to be sent, and without error, no STOP has to
> be
> > > > sent.
> > > > >>
> > > > >> You are in a unique position where you have functional SDHCI
> 3.0
> > > > >> hardware and are able to test Auto-CMD23. Please look at the
> > patch
> > > > set
> > > > >> I sent - it should be trivial to extend current SDHCI patch to
> > use
> > > > >> Auto-CMD23 when possible instead of sending mmc_request->sbc.
> > > > >> Basically, I have a generic improvement that affects all host
> > > > >> controllers. Auto-CMD23 is an optimization of that for SDHCI
> > 3.0.
> > > > >>
> > > > >> Your current patch to enable Auto-CMD23 is not useful as far
> as
> > > > >> non-
> > > > SD
> > > > >> cards are concerned and you push way to much policy and
> > > > >> non-host-related complexity into it.
> > > > >>
> > > > >> Thanks,
> > > > >> A
> > > > >>
> > > > >
> > > > > More clarification:
> > > > >
> > > > > The block layer patch may change slightly
> > > (whitelisting/blacklisting
> > > > > certain MMC devices for using CMD23 for multiblock transfers),
> > but
> > > > the
> > > > > changes to mmc_request and SDHCI are not. So feel free to
> rebase
> > it
> > > > > without waiting for anything. If you need help, I will gladly
> > help
> > > > > you, but keep in mind I don't have SDHCI 3.0 hardware around.
> > > > >
> > > > > Thanks,
> > > > > A
> > > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-
> > mmc"
> > > > in the body of a message to majordomo@vger.kernel.org More
> > majordomo
> > > > info at  http://vger.kernel.org/majordomo-info.html
> 
> 


