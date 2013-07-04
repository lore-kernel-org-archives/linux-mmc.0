From: Peter Turczak <peter@turczak.de>
Subject: Re: [PATCH v2] Add basic support for password protected (locked) SD cards.
Date: Thu, 4 Jul 2013 14:16:00 +0200
Message-ID: <E5D649A7-5C32-4F45-AAAA-9922D897F93A@turczak.de>
References: <04F10DA1-D19F-4AD1-904E-6FD628602F7A@netconsequence.de> <CAELcNGQkwZmnR0aN6DEDiPdJR8e5VNqJGfDyV0w1oYPyp=4bzw@mail.gmail.com> <CBAC2FC9-96A2-4C2C-BD1C-94338EC7A49E@turczak.de> <CAPDyKFqD-qejfY8gkja_ofjOqjnwbjg3C1RhqvfBZo-Y8zhFwA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:46963 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab3GDMQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jul 2013 08:16:03 -0400
In-Reply-To: <CAPDyKFqD-qejfY8gkja_ofjOqjnwbjg3C1RhqvfBZo-Y8zhFwA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ulf,

On 04.07.2013, at 09:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Peter,
> 
> You need a mmc_get|put_card surrounding the call for re-intitalize the card.
Sorry, but I can not find no mmc_get_card function in the current kernel mmc git repository.
These could be found in mmc/card/block.c:
static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk);
static struct mmc_blk_data *mmc_blk_put(struct gendisk *disk);
I used the above, like e.g. the mmc_blk_ioctl_cmd() function which my routine is based upon, like so:
>> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>> +               return -EPERM;
>> +
>> +       md = mmc_blk_get(bdev->bd_disk);
>> +       if (!md) {
>> +               err = -EINVAL;
>> +               goto cmd_err;
>> +       }


Furthermore there are the following get|put functions defined:
drivers/mmc/core/core.c:
static inline void mmc_bus_get(struct mmc_host *host);
static inline void mmc_bus_put(struct mmc_host *host);

Or maybe I did not see it. Which ones did you mean and should I use?
> 
> Kind regards
> Ulf Hansson

Best regards,
  Peter