From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc : general purpose partition support.
Date: Fri, 30 Sep 2011 11:49:22 +0300
Message-ID: <4E858292.40905@intel.com>
References: <1317309431-1898-1-git-send-email-linkinjeon@gmail.com> <1522108758.811204.1317316828352.JavaMail.root@zimbra-prod-mbox-2.vmware.com> <CAKYAXd_1jY23C8NTvP7NizZEseb7G2bbtJYq7RvF1vaJaZgh_Q@mail.gmail.com> <4E855832.4030603@intel.com> <CAKYAXd-rHyL3uwF0B3UpY=ejxkB=+iNYfHQR7kt2ARcHV1NPkg@mail.gmail.com> <CAKYAXd9HzXOpKON+k=Prr-9wMq1Cr6+mZaDbvhTGe=r-1xpGSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44698 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab1I3It1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Sep 2011 04:49:27 -0400
In-Reply-To: <CAKYAXd9HzXOpKON+k=Prr-9wMq1Cr6+mZaDbvhTGe=r-1xpGSA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>
Cc: Andrei Warkentin <awarkentin@vmware.com>, linux-kernel@vger.kernel.org, linus walleij <linus.walleij@linaro.org>, james p freyensee <james_p_freyensee@linux.intel.com>, sebras@gmail.com, Ulf Hansson <Ulf.Hansson@stericsson.com>, stefan xk nilsson <stefan.xk.nilsson@stericsson.com>, per forlin <per.forlin@stericsson.com>, johan rudholm <johan.rudholm@stericsson.com>, cjb@laptop.org, linux-mmc@vger.kernel.org

On 30/09/11 11:11, NamJae Jeon wrote:
> 2011/9/30 NamJae Jeon<linkinjeon@gmail.com>:
>> 2011/9/30 Adrian Hunter<adrian.hunter@intel.com>:
>>> Perhaps rebase against Chris' mmc-next branch
>> I made this patch after rebasing Chris'mmc-next yesterday.
> Hi. Adrian.
> There is the overlapped code between your patch and my patch.
> What should we do ?

Rebase and ensure that boot partitions are only added if
mmc_boot_partition_access(card->host) is true

>>>
>>>
>>>
>>
>

