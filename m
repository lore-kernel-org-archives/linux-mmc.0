From: Stefan Roese <sr@denx.de>
Subject: Re: SDIO "SD2" vs. SD-card "SD3" interface on BayTrail
Date: Mon, 16 Oct 2017 11:40:07 +0200
Message-ID: <dda31052-734d-866f-8f23-624e7551aba9@denx.de>
References: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
 <1499176431.22624.255.camel@linux.intel.com>
 <8a909116-5fec-e7d0-5d30-de8de42612df@denx.de>
 <dc49d8be-dd15-167b-2ab4-d09d1b6ea83d@intel.com>
 <849da4e5-4333-39c4-d546-8e87ae794954@denx.de>
 <00e1d3fa-87b1-6247-7894-806ba0fa7fbd@intel.com>
 <CAG8K7gQNmpMhLdnpua6cds1s7s3aq8B1kS7-z+hg6fjty6Hqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:37095 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdJPJkO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Oct 2017 05:40:14 -0400
In-Reply-To: <CAG8K7gQNmpMhLdnpua6cds1s7s3aq8B1kS7-z+hg6fjty6Hqxg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avri Altman <avri.altman@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Avri,

On 14.10.2017 16:16, Avri Altman wrote:
> Maybe you can post ypur question in the wireless mailing list.
> Intel's wifi driver has a sdio transport layer, and their maintener, 
> Emmanuel Grumbach, is very responsive.

Thanks for the suggestion. As a matter of fact, I was able to solve
this detection issue (U-Boot vs BIOS) last week, by fixing some
power-supply related issues.

I will gladly check the wireless list, if I have specific TI WLAN
related questions.

Thanks,
Stefan
