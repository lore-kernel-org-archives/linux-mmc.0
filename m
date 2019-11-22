From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Date: Fri, 22 Nov 2019 14:49:42 +0100
Message-ID: <CAK8P3a16tv3V78rSb306wCb1H2OF_nkkk1ZO5HAwjrkEGHUScg@mail.gmail.com>
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com> <CACRpkdbzN8_YFT0Di88Oi1j+TTMT-VJLSbv6J8jxP+AsA3j1Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbzN8_YFT0Di88Oi1j+TTMT-VJLSbv6J8jxP+AsA3j1Dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "(Exiting) Baolin Wang" <baolin.wang@linaro.org>, Baolin Wang <baolin.wang7@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, linux-block <linux-block@vger.kernel.org>, Paolo Valente <paolo.valente@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 22, 2019 at 2:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Nov 22, 2019 at 10:50 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > I suppose to make the submission non-blocking, all operations that
> > currently block in the submission path may have to be changed first.
> >
> > For the case of a partition switch (same for retune), I suppose
> > something like this can be done:
> >
> > - in queue_rq() check whether a partition switch is needed. If not,
> >   submit the current rq
> > - if a partition switch is needed, submit the partition switch cmd
> >   instead, and return busy status
> > - when the completion arrives for the partition switch, call back into
> >   blk_mq to have it call queue_rq again.
> >
> > Or possibly even (this might not be possible without signifcant
> > restructuring):
> >
> > - when preparing a request that would require a partition switch,
> >   insert another meta-request to switch the partition ahead of it.
> >
> > I do realize that this is a significant departure from how it was done
> > in the past, but it seems cleaner that way to me.
>
> This partition business really need a proper overhaul.
>
> I outlined the work elsewhere but the problem is that the
> eMMC "partitions" such as boot partitions and the usecase-defined
> "general" partition (notice SD cards do not have this problem)
> are badly integrated with the Linux partition manager.

I think that's a totally orthogonal problem though: we may
well be able to come up with a different way of representing
the extra partitions to user space or as separate block devices,
but in the end, this looks exactly the same to mm
 ->queue_rq() callback. If we have send a cmd to one partition
and want to send the next cmd to another partition, we first
have to send the partition switch cmd.

      Arnd
