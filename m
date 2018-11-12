From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Date: Mon, 12 Nov 2018 18:04:06 -0300
Message-ID: <CAAEAJfBUEj+4RnHmK9RvOv7cghQNr0xNqr5GdVTG+V88+Kzi8Q@mail.gmail.com>
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
 <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com> <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: aaro.koskinen@iki.fi
Cc: Mathieu Malaterre <malat@debian.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Wed, 17 Oct 2018 at 16:50, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Wed, Oct 17, 2018 at 03:38:07PM +0200, Mathieu Malaterre wrote:
> > Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
> > could you confirm that the original mmc driver (kernel from imgtech
> > people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
> > ?
>
> Sorry, cannot confirm or test that. I have only used the mainline kernel
> on this board, since v4.5 or so with my own custom config which has
> been PREEMPT_NONE until now.
>

Aaro,

I spent some time today investigating this issue. I think this driver
has a broken pre-request/post-request implementation.

Will post some patches soon.

Thanks for the report,
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
