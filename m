From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: add unstuck function if host is in deadlock state
Date: Thu, 14 Nov 2019 15:49:21 +0100
Message-ID: <CAPDyKFpvOdwnwNa94ppF_Gum26ML52oeXDSeR1qKtSaH_wQU+g@mail.gmail.com>
References: <20191011131502.29579-1-ludovic.Barre@st.com> <20191011131502.29579-2-ludovic.Barre@st.com>
 <CAPDyKFqE09nqdev_qewwNzjjUuhm0UUC03tgvY=ZukYY4az7wg@mail.gmail.com> <d8d82f39-319b-c8f8-255a-a02a81980671@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8d82f39-319b-c8f8-255a-a02a81980671@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 17:54, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
>
> Le 10/21/19 =C3=A0 3:35 PM, Ulf Hansson a =C3=A9crit :
> > On Fri, 11 Oct 2019 at 15:15, Ludovic Barre <ludovic.Barre@st.com> wrot=
e:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> After a request a host may be in deadlock state, and wait
> >> a specific action to unstuck the hardware block before
> >> re-sending a new command.
> >
> > Rather than talking about "unstuck" and "deadlock", how about instead
> > describing that an MMC controller, may end up in an non-functional
> > state hanging on something. Then to allow it to serve new requests it
> > needs to be reset.
> >
>
> Ok, deadlock naming is perhaps too stronght and scary.
>
> >>
> >> This patch adds an optional callback mmc_hw_unstuck which
> >> allows the host to unstuck the controller. In order to avoid
> >> a critical context, this callback must be called when the
> >> request is completed. Depending the mmc request, the completion
> >> function is defined by mrq->done and could be in block.c or core.c.
> >
> > I think it's important to state exactly what is expected from the core
> > perspective, by the mmc host driver when it calls this new host ops.
> > We need to clarify that.
> >
> >>
> >> mmc_hw_unstuck is called if the host returns an cmd/sbc/stop/data
> >> DEADLK error.
> >
> > To me, this approach seems a bit upside-down. Although, I have to
> > admit that I haven't thought through this completely yet.
> >
> > The thing is, to make this useful for host drivers in general, I
> > instead think we need to add timeout to each request that the core
> > sends to the host driver. In other words, rather than waiting forever
> > in the core for the completion variable to be set, via calling
> > wait_for_completion() we could call wait_for_completion_timeout(). The
> > tricky part is to figure out what timeout to use for each request.
> > Perhaps that is even why you picked the approach as implemented in
> > @subject patch instead?
>
> On STM32 SDMMC variant, If datatimeout occurs on R1B request the Data
> Path State Machine stays in busy and only the DPSM is non-functional.
> The hardware block waits a software action to abort the DPSM.
>
> Like the CPSM stay alive, the framework can sent some requests
> (without data, example cmd13:status) before to had this
> timeout issue.
>
> POV framework I understand the possibility to have a completion_timeout,
> for more safety. But for this specific sdmmc case, I'm not fan, because
> the completion timeout error will occur several requests after the real
> issue (which put the DPSM non-functional). when the completion timeout
> occurs we can't know if it's due to R1B timeout or an other issue.

Right, I see what you are saying. So let's drop the approach suggested
in $subject series.

>
> To resolve the SDMMC's specificity, I can proposed you to add a threaded
> irq in mmci drivers to abort the DPSM and terminate the request.

Okay, so the threaded IRQ handler is needed, because the reset
operation may sleep (can't be executed in atomic context). Right?

That should work, but... let's move the discussion to that patch instead.

>
> >
> > Anyway, the typical scenario I see, is that the host driver is
> > hanging, likely waiting for an IRQ that never get raised. So, unless
> > it implements it own variant of a "request timeout" mechanism, it
> > simple isn't able to call mmc_request_done() to inform the core about
> > that the request has failed.
> >
> > For comments to the code, I defer that to the next step, when we have
> > agreed on the way forward.
> >
> > Kind regards
> > Uffe
> >

Kind regards
Uffe
