From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Make sure we don't get stuck when we get an
 error
Date: Wed, 21 May 2014 18:05:33 +0900
Message-ID: <000f01cf74d3$d2938b40$77baa1c0$%jun@samsung.com>
References: <1395901126-6141-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOL_JVjOfLNspb14kRxcAXjpEwX4WkvmM+izryZbZBE4XA@mail.gmail.com>
 <CAPz6YkVwT0PrcLP1MJy0vVRw811+_7PwsV_ggKxQkqrjOWeWWw@mail.gmail.com>
 <002001cf6c59$b5b5e680$2121b380$%jun@samsung.com>
 <CAD=FV=X=9cTvST5cM=H9H23SMD28cHSExXt3YR=v2AQ6dFJY5w@mail.gmail.com>
 <001b01cf6e67$2183b400$648b1c00$%jun@samsung.com>
 <003a01cf73cd$fa2ee160$ee8ca420$%jun@samsung.com>
 <CAD=FV=Vtpup1DaAnN1cO4R5CgxMKa0aosw53sj1eKcUPJsEoYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAD=FV=Vtpup1DaAnN1cO4R5CgxMKa0aosw53sj1eKcUPJsEoYg@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Sonny Rao' <sonnyrao@chromium.org>, 'Yuvaraj Kumar' <yuvaraj.cd@gmail.com>, 'Grant Grundler' <grundler@chromium.org>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'sunil joshi' <joshi@samsung.com>, 'Tomasz Figa' <t.figa@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 21, 2014, Doug Anderson wrote:
> Seungwon,
> 
> On Mon, May 19, 2014 at 6:51 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> > >> >> +                       } else {
> >> > >> >> +                               /*
> >> > >> >> +                                * If we don't have a command complete now we'll
> >> > >> >> +                                * never get one since we just reset everything;
> >> > >> >> +                                * better end the request.
> >> > >> >> +                                *
> >> > >> >> +                                * If we do have a command complete we'll fall
> >> > >> >> +                                * through to the SENDING_STOP command and
> >> > >> >> +                                * everything will be peachy keen.
> >> > >> >> +                                *
> >> > >> >> +                                * TODO: I guess we shouldn't send a stop?
> >
> > Please remove TODO:
> 
> OK
> 
> > We already reset controller in dw_mci_data_complete() through "mmc: dw_mmc: change to use
> recommended reset procedure"?
> > I guess it depends on that patch.
> > Then, we don't need to stop sequence anymore.
> 
> Even without that patch we've still pretty much stopped everything in
> dw_mci_fifo_reset(), so I'm not sure there's any strong dependency.
> ...but in our tree this did land after the patch you mention, so you
> could wait until it lands if you want.
> 
ciu-reset or stop/abort cmd is needed for recovery of controller FSM after getting error.
dw_mci_fifo_reset eventually has ciu-reset from that patch.
I think it's fine to apply after that.

> 
> NOTE: We found that on some machines we were getting warnings after
> enabling tuning and using this patch.  The warnings were benign, but
> we should probably squash the fix into this patch.  See
> <https://chromium-review.googlesource.com/#/c/200652/> for details.
Can it be accessible?

Thanks,
Seungwon Jeon

> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
