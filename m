From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-pci: Use ACPI to set max frequency of sdio host
Date: Tue, 22 Nov 2016 18:30:57 +0100
Message-ID: <CAPDyKFr2o48ent2JtMyu4EqZHkuVq_yM=TvZKM0Hr=V0+T256g@mail.gmail.com>
References: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
 <CAPDyKFrbfiTuU6zvQ8RR9pcO+x+9AZUejHrw396+Xsn2gCMsGA@mail.gmail.com> <20161122163739.GA10111@zach-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122163739.GA10111@zach-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 November 2016 at 17:37, Zach Brown <zach.brown@ni.com> wrote:
> On Tue, Nov 22, 2016 at 09:27:29AM +0100, Ulf Hansson wrote:
>>
>> Please try to not forget to bump the version number and to provide a
>> history of the what changes between revisions. It makes life easier
>> when reviewing and when I am about to apply patches.
>>
>
> Sorry, I'll make sure to include a history.
> When switching from RFC to PATCH should the version number of the PATCH
> be 1 or the lastest RFC version plus 1? Or does it not matter either way

RFC + 1, that would be best. Although it doesn't matter that much.

> as long as the history is present?

Yes, this is the most important part.

Kind regards
Uffe
