From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] Add trace events for SD registers.
Date: Tue, 23 Apr 2019 08:29:15 +0200
Message-ID: <CAPDyKFqYNMhDKy94zV8Bk80OUiS9JNFf2EmkbhJ0W_N=5=bZJQ@mail.gmail.com>
References: <20190416183257.247902-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183257.247902-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-trace-devel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org, Steven Rostedt <rostedt@goodmis.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Apr 2019 at 20:33, Raul E Rangel <rrangel@chromium.org> wrote:
>
> I am not able to make a single event class for all these registers. They
> all have different struct sizes and different printf formats.
>
> Thanks for the reviews!
>
> Changes in v2:
> - Made trace_sd_scr print out flags.
> - Add BUILD_BUG_ON to make sure tracing stays in sync with structs.
> - memcpy using sizeof(__entry->raw)
>
> Raul E Rangel (4):
>   mmc: core: Add trace event for SD SCR response
>   mmc: core: Add trace event for SD SSR response
>   mmc: core: Add trace event for SD OCR response
>   mmc: core: Add trace event for CSD response
>
>  drivers/mmc/core/mmc.c     |   4 +
>  drivers/mmc/core/sd.c      |  10 ++
>  drivers/mmc/core/sd_ops.c  |   6 ++
>  include/trace/events/mmc.h | 204 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>
> --
> 2.21.0.392.gf8f6787159e-goog
>

Why do you need this? We already have these card registers reflected
though sysfs files, isn't that sufficient?

Kind regards
Uffe
