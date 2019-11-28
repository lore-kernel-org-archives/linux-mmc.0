From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Date: Thu, 28 Nov 2019 07:15:09 -0500
Message-ID: <yq1v9r46vua.fsf@oracle.com>
References: <cover.1573456283.git.baolin.wang@linaro.org>
        <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
        <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
        <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
        <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
        <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
        <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
        <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
        <20191127090023.GA23040@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127090023.GA23040@infradead.org> (Christoph Hellwig's
        message of "Wed, 27 Nov 2019 01:00:23 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>, "(Exiting) Baolin Wang" <baolin.wang@linaro.org>, Baolin Wang <baolin.wang7@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Lyra Zhang <zhang.lyra@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, linux-block <linux-block@vger.kernel.org>, Paolo Valente <paolo.valente@linaro.org>
List-Id: linux-mmc@vger.kernel.org


Christoph,

> equivalent to SCSI logical units and nvme namespace, just with a
> pretty idiotic design decision that only allows I/O to one of them at
> a time.  The block layer way to deal with them is to use a shared
> tagset for multiple request queues, which doesn't use up a whole lot
> of resources.  The only hard part is the draining when switching
> between partitions, and there is no really nice way to deal with that.
> If requests are batched enough we could just drain and switch every
> time an other partition access comes in.

This mirrors single_lun in SCSI closely. I was hoping we could
eventually get rid of that travesty but if MMC needs something similar,
maybe it would be good to move that plumbing to block?

-- 
Martin K. Petersen	Oracle Linux Engineering
