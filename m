From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: Add a quirk for the Ricoh 0xe22 SD card reader
Date: Wed, 26 Dec 2012 11:01:39 -0700
Message-ID: <CAErSpo4t9fQzg2GwEB0Ck4ffyErSmsfV3-Va1fvxKXdo59gd9A@mail.gmail.com>
References: <33c411da9bb44eae8a5f9e0609f8eb0aa4eda600.1354385950.git.luto@amacapital.net>
 <33c411da9bb44eae8a5f9e0609f8eb0aa4eda601.1354385950.git.luto@amacapital.net> <87ehii6dv4.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <87ehii6dv4.fsf@laptop.org>
Sender: linux-pci-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andy Lutomirski <luto@amacapital.net>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Manoj Iyer <manoj.iyer@canonical.com>, stable@kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 21, 2012 at 7:05 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Bjorn,
>
> On Sat, Dec 01 2012, Andy Lutomirski wrote:
>> Otherwise it fails like this on cards like the Transcend 16GB SDHC card:
>> mmc0: new SDHC card at address b368
>> mmcblk0: mmc0:b368 SDC   15.0 GiB
>> mmcblk0: error -110 sending status command, retrying
>> mmcblk0: error -84 transferring data, sector 0, nr 8, cmd respons
>> e 0x900, card status 0xb0
>>
>> Tested on my Lenovo x200 laptop.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> Acked-by: Chris Ball <cjb@laptop.org>
>
> Ping -- this is an important patch for getting SD cards working on
> Thinkpads, please can you pick it up?

I put this in my for-linus branch, which will become part of v3.8.
Thanks for the reminder!
