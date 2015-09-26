From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Fri, 25 Sep 2015 21:59:53 -0700
Message-ID: <20150926045953.GB19692@xsjsorenbubuntu>
References: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
 <20150914150751.GI19678@xsjsorenbubuntu>
 <55F76F60.7060506@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F76F60.7060506-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-09-15 at 09:07AM +0800, Shawn Lin wrote:
> On 2015/9/14 23:07, S=C3=B6ren Brinkmann wrote:
> >Hi Shawn,
> >
> >overall, it looks good to me. I have some questions though.
> >
> >On Mon, 2015-09-14 at 02:29PM +0800, Shawn Lin wrote:
>=20
> [...]
>=20
> >>+err_phy_exit:
> >>+	phy_init(phy);
> >
> >Just to confirm, are these actions in the error path correct? E.g.
> >if the power_off() call fails, is it safe to call power_on()? Isn't
> >the phy still powered on? (this would apply to other error paths too=
)
> >
>=20
> Cool question!
>=20
> While writing this, I had read generic phy stuffs deliberately to fin=
d a
> solution for a case: how to deal with ping-pong fails? In another wor=
d, if
> power_off call fails, then we should call power_on, but unfortunately=
 it
> fails again then we call power_off... so endless nested err handling.=
=2E. No
> answer yet.
>=20
> So, I assumed two cases happened when power_off call fails:
> (1) *real power_off* is done, but some other stuffs in the calling pa=
th
> fail, so phy is really power_off in theory. We need to power_on it ag=
ain,
> but if it fail, we don't know PHY is on or off since we don't know po=
wer_on
> fails for what? *real power on* ? some other stuffs?
>=20
> (2) *real power_off* isn't completed, so indeed it's *still* in power=
_on
> state. The reason we never need to check the return value of power_on=
 cross
> the err handling is that whether power_on call successfully or not, i=
t's
> always make phy in power_on state.
>=20
> Now, let's think about case(1).
> After reading dozens of sample codes(such as USB, UFS, MBUS) that ado=
pt
> generic phy framework for PHY management, real thing should be like t=
hat:
> they NEVER deal with case(1).
>=20
> It's a trick of sub-phy drivers themself. power_on/off calling path r=
eturn
> err for two case:
> <1>  phy_runtime callback fails. It's after *real power on/off*, so
> definitely *real power on/off* is conpleted. That is the case(2) I me=
ntioned
> above.
> <2>  sub-phy drivers return err for  phy->ops->power_off(phy); Look
> into all the sub-phy drivers twice, we find that they always return s=
uccess
> for phy->ops->power_off hook. Why? Because all of them
> write registers to enable/disable something, always consider things g=
oing
> well. Actually if we write value into a register, we have to think th=
at it's
> functional.
>=20
> Anyway, back to this patch.
> Indeed we also write value into arasan phy's register to do
> phy_power_on/off/init/exit to make things work. Right, we return succ=
ess
> state for all of these them just as all the other sub-phy drivers do.
>=20
> Feel free to let me know if I make mistakes or misunderstanding above=
=2E
>=20
> >>+	return ret;
> >>+}
>=20
> [...]
>=20
> >>+		}
> >>+	}
> >
> >I assume you looked at options for having the error paths in a
> >consolidated location? I guess this may be the nicest solution since=
 all
> >of this is in this conditional block?
> >
>=20
> yep, otherwise we should add some *if* statements to check sdhci_aras=
an->phy
> cross the err handles. And I intent to strictly limit
> the phy stuffs under the scope of arasan,sdhci-5.1 currently.
>=20
> >Feel free to add my
> >Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> >
>=20
> Thanks, S=C3=B6ren. :)

Makes all sense to me. Thanks for all the details.

	S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
