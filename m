From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
Date: Fri, 16 Jan 2015 10:13:33 +0100
Message-ID: <CAPDyKFrzkzHF3AJ7n4Uh8kQr-zdhLCqdxOtgXpxtRWj6=0h+2w@mail.gmail.com>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
	<1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
	<20150115165825.GL16217@leverpostej>
	<20150116075308.3f4e250a@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150116075308.3f4e250a-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 15 January 2015 at 19:53, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> wrote:
> On Thu, 15 Jan 2015 16:58:26 +0000 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>
>> Hi Ulf,
>>
>> On Wed, Jan 14, 2015 at 01:02:08PM +0000, Ulf Hansson wrote:
>> > The simple MMC power sequence provider, intends to supports a set of
>> > common properties between SOC designs. It thus enables us to re-use the
>> > same provider for several SOCs.
>> >
>> > In this initial step, let's add the top level description of the MMC
>> > power sequence and describe the compatible string for the simple MMC
>> > power sequence provider.
>> >
>> > Following patches will step by step add support for new properties to
>> > the simple MMC power sequence provider.
>> >
>> > Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> > ---
>> >
>> > Changes in v2:
>> >     - None.
>> >
>> > ---
>> >  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt      | 18 ++++++++++++++++++
>> >  Documentation/devicetree/bindings/mmc/mmc.txt          |  5 +++++
>> >  2 files changed, 23 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> > new file mode 100644
>> > index 0000000..e1b7f9c
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> > @@ -0,0 +1,18 @@
>> > +* The simple MMC power sequence provider
>> > +
>> > +System on chip designs may specify a specific MMC power sequence. To
>> > +successfully detect an (e)MMC/SD/SDIO card, that power sequence must be
>> > +maintained while initializing the card.
>> > +
>> > +The simple MMC power sequence provider, intends to supports a set of common
>> > +properties between SOC designs. It thus enables us to re-use the same provider
>> > +for several SOC designs.
>> > +
>> > +Required properties:
>> > +- compatible : contains "mmc,pwrseq-simple".
>>
>> Nit: "mmc" is not a vendor prefix.
>>
>> > +
>> > +Example:
>> > +
>> > +   sdhci0_pwrseq {
>> > +           compatible = "mmc,pwrseq-simple";
>> > +   }
>>
>> I'm a little confused here. What specific sequence is described by this
>> node? We don't appear to have referred to any resources used as part of
>> that sequence, and the description above only mentions that there could
>> be a specific sequence, not what that sequence is.
>>
>> So I don't think this makes sense on its own, and should probably be
>> folded with patches adding the initial support for the resources used as
>> part of the sequence (e.g. the GPIOs added in a later patch).
>>
>
> I guess I assumed that this "simple" referred to the current behaviour, which
> includes some of vmmc-supply, vqmmc-supply, vmmc_aux-supply and pbias-supply
> being switched at "appropriate" times.
>
> Would it make sense to bring all of these explicitly under the "pwrseq"
> umbrella, leaving the current behaviour only when no pwrseq node is provided?

In principle there is nothing that prevents us from following your
suggestion. But why should we?

Moreover, I don't think it's required at this point, let's first get
the basic mmc-pwrseq support in place. Then we can evolve it. :-)

>
> Also, it isn't clear to me whether the need for power/reset is a function of
> the mmc-host, or a function of the device attached to the host.  I suspect
> some are needed by one, some by the other.  Any by both?

To me the the power is coupled with the host and thus controlled by
the mmc layer. But I guess we can discuss this in a forever long loop.
:-)

They may be other resources which is coupled with an SDIO function /
eMMC,SDIO card, such as irqs. Those shall be described in the child
node of the host.
I have queued the below patchset from Hans, which I believe should address this:

https://www.mail-archive.com/linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg27241.html

>
> Should the two needs be kept separate?

Yes, I think so.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
