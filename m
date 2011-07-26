From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] mmc: mmc_test: avoid stalled file in debugfs
Date: Tue, 26 Jul 2011 10:01:55 +0300
Message-ID: <1311663715.3903.21.camel@smile>
References: <095a90240876c249ed33aa36f2543b54a0b68fc2.1311340371.git.andriy.shevchenko@linux.intel.com>
	 <CAJ0pr19UbhitnopWFyh19ADErn9=VQ6Gxank-Ntc1_O4rGBb-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ0pr19UbhitnopWFyh19ADErn9=VQ6Gxank-Ntc1_O4rGBb-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2011-07-26 at 00:15 +0200, Per Forlin wrote: 
> > +               file = debugfs_create_file(name, mode, card->debugfs_root,card,
> > +                       fops);
> Move card to next line together with fops and indent.
> +               file = debugfs_create_file(name, mode, card->debugfs_root,
> +                                                    card, fops);
Hmm... Its length is exact 80 symbols which is OK for checkpatch.pl.
Anyway, thanks for review.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
