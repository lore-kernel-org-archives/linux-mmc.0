From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Mon, 22 Oct 2018 02:21:47 -0600
Message-ID: <fa57d440-dff1-e260-c8c9-6d4bf04221a8@kernel.dk>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <E2DDE0B9-F693-4EF3-B90C-C57F787B4DB3@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <E2DDE0B9-F693-4EF3-B90C-C57F787B4DB3@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

On 10/19/18 4:59 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 15 ott 2018, alle ore 20:26, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>> ...
>>> This kind of policy does not belong in the kernel, at least
>>> not in the current form. If we had some sort of "enable best
>>> options for a desktop" then it could fall under that umbrella.
>>>
>>
>> I don't think bfq can be considered a scheduler for only desktops any
>> longer.
>>
> 
> Hi Jens,
> this reply of mine went on bugging me, until I understood my mistake.
> 
> The fact that I consider bfq good also for servers *does not* imply
> that having bfq in desktops is to be refused.
> 
> As for the option that you are hinting at, I also acknowledge that it
> would be trivial for an admin/developer to know whether a given kernel
> is meant for a desktop/personal system, while it is more difficult to
> choose explicitly among the various I/O schedulers available.
> 
> So, I apologize for my shortsighted, initial reply, and ask you if can
> elaborate a little more on this.  I'm willing to help, if I can.

I think I've written about this multiple times now, but for me it
really just boils down to sane default, and policy in the kernel.
BFQ is very complicated, about 10K lines of code. I'm not comfortable
making that the default right now - as I've mentioned in other
replies, I think something like that should be driven by the distros
as they will ultimately be the ones that usually get complaints
about behavioral changes that impact performance adversely. This isn't
just about running some benchmarks and calling it a day.

Maybe some day we can make it the default on mq for single queue
devices, but I just don't think we are there yet in terms of
coverage. 

While I don't work for a distro anymore, I do have my hands dirty
with a fairly substantial deployment at work. There we run mq-deadline
on single queue devices, and kyber on multiqueue capable devices.

-- 
Jens Axboe


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
