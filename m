From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Date: Wed, 27 Nov 2019 13:01:06 +0100
Message-ID: <CAK8P3a0gUWf_+ZmscuFanvPG=wN09ELL-JpByjJJM4Lo1FYmrQ@mail.gmail.com>
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
 <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de> <20191127090023.GA23040@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127090023.GA23040@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, "(Exiting) Baolin Wang" <baolin.wang@linaro.org>, Baolin Wang <baolin.wang7@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, linux-block <linux-block@vger.kernel.org>, Paolo Valente <paolo.valente@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 27, 2019 at 10:00 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 26, 2019 at 12:17:15PM +0100, Hannes Reinecke wrote:
>  If requests are batched enough we could just drain
> and switch every time an other partition access comes in.  Especially
> so if people only use partitions for boot partitions and other rarely
> used areas.

We only support a single user partition plus up to two boot partitions that
are accessed rarely, I don't think there is any reason to optimize switching
between them.

The only change that I think we need here is to change the partition switch
from something that is done synchronously during ->queue_rq() to
something that fits better into normal scheme of sending a cmd to
the device, returning BLK_STS_RESOURCE from ->queue_rq.
Possibly this could even be turned into a standard struct request that is
added between two normal requests for different partitions at some
point, if this simplifies the logic (I suspect it won't, but it may be worth
a try).

      Arnd
