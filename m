From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] Add trace events for SD registers.
Date: Mon, 29 Apr 2019 11:57:02 +0200
Message-ID: <CAPDyKFqerMeQey0wJW3Ctohh77CJs6-PxSaR=T6ive_Rx-oMMA@mail.gmail.com>
References: <20190416183257.247902-1-rrangel@chromium.org> <CAPDyKFqYNMhDKy94zV8Bk80OUiS9JNFf2EmkbhJ0W_N=5=bZJQ@mail.gmail.com>
 <20190424153115.GA186956@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424153115.GA186956@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-trace-devel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org, Steven Rostedt <rostedt@goodmis.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Wed, 24 Apr 2019 at 17:31, Raul Rangel <rrangel@chromium.org> wrote:
>
> On Tue, Apr 23, 2019 at 08:29:15AM +0200, Ulf Hansson wrote:
> > On Tue, 16 Apr 2019 at 20:33, Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > I am not able to make a single event class for all these registers. They
> > > all have different struct sizes and different printf formats.
> > >
> > > Thanks for the reviews!
> > >
> > > Changes in v2:
> > > - Made trace_sd_scr print out flags.
> > > - Add BUILD_BUG_ON to make sure tracing stays in sync with structs.
> > > - memcpy using sizeof(__entry->raw)
> > >
> > > Raul E Rangel (4):
> > >   mmc: core: Add trace event for SD SCR response
> > >   mmc: core: Add trace event for SD SSR response
> > >   mmc: core: Add trace event for SD OCR response
> > >   mmc: core: Add trace event for CSD response
> > >
> > >  drivers/mmc/core/mmc.c     |   4 +
> > >  drivers/mmc/core/sd.c      |  10 ++
> > >  drivers/mmc/core/sd_ops.c  |   6 ++
> > >  include/trace/events/mmc.h | 204 +++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 224 insertions(+)
> > >
> > > --
> > > 2.21.0.392.gf8f6787159e-goog
> > >
> >
> > Why do you need this? We already have these card registers reflected
> > though sysfs files, isn't that sufficient?
> >
> I was not actually aware that the registers were exposed via sysfs. I
> was debugging a problem where the host controller was returning all
> zeros when reading from the card. I wasn't aware that it was returning
> all zeros until I added tracing. It made it quite easy to diagnose the
> problem by just diffing the two traces.

This sounds like a quite an unusual problem, and I don't think having
the buffers printed via tracing is worth it.

Moreover, we already have tracing per command/request (but don't print
the buffers), that should cover most of error cases during init, don't
you think?

[...]

Kind regards
Uffe
