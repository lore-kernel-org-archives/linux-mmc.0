From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s3mci: mark debug_regs[] as static
Date: Wed, 3 Jan 2018 23:45:18 +0100
Message-ID: <CAK8P3a3U=J7knkExNfTG9aBy7UAw9fmwijOvq0PDRwzz73iH+g@mail.gmail.com>
References: <20180103092705.1949763-1-arnd@arndb.de> <CAPDyKFoxizZ5vJ4h_hSo=WaqzjMc7Zq59njuESTdeMaXCV1YQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38780 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeACWpT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 17:45:19 -0500
In-Reply-To: <CAPDyKFoxizZ5vJ4h_hSo=WaqzjMc7Zq59njuESTdeMaXCV1YQA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Heiner Kallweit <hkallweit1@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Sergio Prado <sergio.prado@e-labworks.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jan 3, 2018 at 5:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 January 2018 at 10:26, Arnd Bergmann <arnd@arndb.de> wrote:
>> The global array clashes with a newly added symbol of the same name:
>>
>> drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
>> drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here
>>
>> We should fix both, this one addresses the s3cmci driver by removing
>> the symbol from the global namespace.
>>
>> Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")
>
> Seems like we need a stable tag as well, would you mind adding it in
> the next re-spin?

It doesn't seem necessary here, this only causes problems on the latest
linux-next kernel that has the b3ec9a6736f2 commit as well.

Obviously, you can just add the Cc:stable tag when applying the patch
when you consider it appropriate.

>> Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/mmc/host/s3cmci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
>> index 36daee1e6588..24b27e0957e7 100644
>> --- a/drivers/mmc/host/s3cmci.c
>> +++ b/drivers/mmc/host/s3cmci.c
>> @@ -1421,7 +1421,7 @@ static const struct file_operations s3cmci_fops_state = {
>>
>>  #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
>>
>> -struct s3cmci_reg {
>> +static struct s3cmci_reg {
>>         unsigned short  addr;
>>         unsigned char   *name;
>>  } debug_regs[] = {
>
> I am not very fond of these kind of declarations/definitions. How
> about if we instead move the declaration of debug_regs[] to a separate
> line? Moreover, should it be const?
>
> static struct s3cmci_reg debug_regs[] = {

Ok, I'll resend with that changed.

      Arnd
