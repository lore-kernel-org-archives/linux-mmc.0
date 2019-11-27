From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Date: Wed, 27 Nov 2019 01:00:23 -0800
Message-ID: <20191127090023.GA23040@infradead.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
 <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
 <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, "(Exiting) Baolin Wang" <baolin.wang@linaro.org>, Baolin Wang <baolin.wang7@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, linux-block <linux-block@vger.kernel.org>, Paolo Valente <paolo.valente@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 26, 2019 at 12:17:15PM +0100, Hannes Reinecke wrote:
> Aligning with the 'traditional' linux way for partition handling is
> definitely the way to go IMO; otherwise you'll end up having to worry
> about resource allocation between distinct queues (like you have to do
> now), and will be having a hard time trying to map it properly to the
> underlying hardware abstraction in blk-mq.

Sorry, but this is complete bullshit.  Except for the very unfortunate
name MMC partitions have nothing to do with partitions.  They are a
concept roughly equivalent to SCSI logical units and nvme namespace,
just with a pretty idiotic design decision that only allows I/O to one
of them at a time.  The block layer way to deal with them is to use
a shared tagset for multiple request queues, which doesn't use up a
whole lot of resources.  The only hard part is the draining when
switching between partitions, and there is no really nice way to
deal with that.   If requests are batched enough we could just drain
and switch every time an other partition access comes in.  Especially
so if people only use partitions for boot partitions and other rarely
used areas.  If that doesn't work out we'll just have to reject other
partition access and then use a timer and/or counter to eventually
switch and provide basic fairness.
