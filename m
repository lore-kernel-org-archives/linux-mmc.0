From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Mon, 22 Oct 2018 02:08:42 -0600
Message-ID: <1643e1b5-bb05-bbbb-83c8-02c3a70a147c@kernel.dk>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <e54c3943-0335-6db4-1c86-f093432fd84b@kernel.dk>
 <20181018072110.GI23493@quack2.suse.cz>
 <3a844733-ddcd-2f5f-80fc-645daeec0046@kernel.dk> <20181019082203.GA10361@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181019082203.GA10361@amd>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Johannes Thumshirn <jthumshirn@suse.de>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

On 10/19/18 2:22 AM, Pavel Machek wrote:
> Hi!
> 
>>>> Which is also the approach that I've been advocating for here, instead
>>>> of a kernel patch...
>>>
>>> I know you've been advocating the use of udev for IO scheduler selection.
>>> But do you want to force everybody to use udev? And for people who build
>>> their own (usually small) systems, do you want to force them to think about
>>> IO scheduler selection and writing appropriate rules? These are the
>>> problems people were mentioning and I'm not sure what is your opinion on
>>> this.
>>
>> I don't want to force everybody to use udev, use whatever you like on
>> your platform. For most people that is udev, for embedded it's something
>> else. As you said, distros already do this via udev. When I've had to
>> do it on my systems, I've added a udev rule to do it.
> 
> This is not really helpful.
> 
> So you want me and everyone else and everyone on embedded to mess with
> udev? No, thanks.

Did you read what I wrote?

> There are people booting with init=/bin/bash, too, running fsck. Would
> not it be nice to use reasonable schedulers there?

I can pretty much guarantee that fsck will run the same speed,
regardless of scheduler. And users generally don't care about
ultimate fairness on the device while running fsck...

If you (or someone else) doesn't want to use udev, use whatever
you want. You're doing something heavily customized at that
point anyway, surely this isn't a show stopper.

>> My opinion is that the kernel makes various schedulers available.
>> Deciding which one to use is policy that should go into user space.
>> The default should be something that's solid and works, fancier
>> setups and tuning should be left to user space.
> 
> Kernel should do reasonable thing by default, and it seems to be easy
> in this case.

I agree, we just differ on what we consider the reasonable choice to
be.

-- 
Jens Axboe


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
