From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 0/4] mmc: sdhci: Support maximum DMA latency request
 via PM QoS
Date: Thu, 26 Mar 2015 10:29:06 +0200
Message-ID: <5513C352.2080208@intel.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com> <20150325194259.GB381@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150325194259.GB381@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 25/03/15 21:43, Pavel Machek wrote:
> Hi!
> 
>> Here are some patches to address an issue with SDHCI
>> in Intel Baytrail. Intel Baytrail has been observed
>> sometimes to hang if host controllers are using DMA
>> while deep C-states are used. Workaround that by
> 
> I wonder if there is more information on this one? I see your address
> is "@intel". For example which C states are affected, and if there's

The problem starts at C6 - I will add that to the commit message.

> maybe Intel errata number to quote?

I wasn't able to find an errata number.
