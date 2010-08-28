From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH v3] mmc: Make ID freq configurable
Date: Sat, 28 Aug 2010 08:44:20 +0800
Message-ID: <4C785BE4.6010906@yahoo.es>
References: <20090702135849.21370282@hskinnemoen-d830> <1246537056.2980.60.camel@linux-51e8.site> <4B3E570C.2060602@yahoo.es> <63809451-ED1D-487A-AE63-F72B23D136D8@niasdigital.com> <4B3F019F.6010306@yahoo.es> <49985427-DCB9-40E1-815B-43C812B41DE3@niasdigital.com> <20100102130809.121b7e10@mjolnir.ossman.eu> <AD8E15FA-A476-4275-A750-5EB587A93CEC@niasdigital.com> <20100103003804.66021fe9@mjolnir.ossman.eu> <4B42648A.2040305@yahoo.es> <20100827204415.GU23079@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100827204415.GU23079@void.printf.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

 On 28-8-2010 04:44, Chris Ball wrote:
> Hi,
>
> This looks like the best of the min_freq patches I've seen, and is
> implementing a suggestion of Pierre's.  Should we take it?
>
> - Chris.
>
> On Tue, Jan 05, 2010 at 05:58:34AM +0800, Hein_Tibosch wrote:
>> Below a patch which tries mmc-initialization using several frequencies
>> from an array 400, 300, 200 and 100.
>>
>>
>> Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
>> <cut>
Hi Chris,

Thanks. I can confirm that the above patch has been working properly for
7 months now, using various SD-cards.

Here it tries 3 frequencies, which takes 290 ms:

   000 mmc_rescan: trying 400000 Hz
       Waiting 1sec before mounting root device...
   061 mci: F now 400000 (actual 397727)
       usb 1-2: configuration #1 chosen from 1 choice
   126 mmc_rescan: trying 300000 Hz
       input: eGalax Inc. USB TouchController as /class/input/input1
   193 mci: F now 300000 (actual 299145)
   227 mmc_rescan: trying 200000 Hz
   255 mci: F now 200000 (actual 200000)
   290 mmc0: new SD card at address e624

In a meanwhile it is doing other things, so not much time is wasted.
But most importantly: it never failed to initialize a card.

Hein Tibosch
