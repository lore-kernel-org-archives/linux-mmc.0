From: Pankaj Jangra <jangra.pankaj9@gmail.com>
Subject: Re: [PATCH 1/2] regulator: core.c Pass voltage to notifier when
 setting voltage
Date: Sat, 16 Jun 2012 00:20:04 +0530
Message-ID: <CADTbHxpfQpKMkwzUakUUzt1mKO5rQ2A7_vuh9SA7i6Cq0VinZg@mail.gmail.com>
References: <1339784856-1779-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339784856-1779-1-git-send-email-prakity@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Rakity <philipspatches@gmail.com>
Cc: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Jun 15, 2012 at 11:57 PM, Philip Rakity
<philipspatches@gmail.com> wrote:
> V3
> --
>
> Fix type where data argument was not passed in
> blocking_notifier_call_chain.
>
> edits to check in comments (below)
>
> V2
> --
>
> Incorporate performance suggestions made by Mark Brown
> Use linux-next as base code rather than mmc-next
>
> The voltage being set should be passed to the call in handler
> requesting the callback. =A0Currently this is not done.
>
> The callin handler cannot call regulator_get_voltage() to get the

"The calling"

> information since the mutex is held by the regulator and
> deadlock occurs.
>
> Without this change the receiver of the call in cannot know what
> action to take. =A0This is used, for example, to set PAD voltages
> when doing SD vccq voltage changes.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---

Since you are submitting your patch from the different email than your
Singed-off email. So you should put in first line of message
=46rom: <your real email>.

Regards,
Pankaj Jangra
