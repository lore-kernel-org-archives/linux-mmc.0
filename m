From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Date: Wed, 17 Oct 2018 22:50:50 +0300
Message-ID: <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
 <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Oct 17, 2018 at 03:38:07PM +0200, Mathieu Malaterre wrote:
> Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
> could you confirm that the original mmc driver (kernel from imgtech
> people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
> ?

Sorry, cannot confirm or test that. I have only used the mainline kernel
on this board, since v4.5 or so with my own custom config which has
been PREEMPT_NONE until now.

A.
