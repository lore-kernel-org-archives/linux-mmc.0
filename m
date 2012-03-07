From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency
 constraints
Date: Wed, 07 Mar 2012 10:31:05 +0200
Message-ID: <4F571CC9.7050609@intel.com>
References: <201203040101.53177.rjw@sisk.pl> <4F55E73C.10907@intel.com> <Pine.LNX.4.64.1203061436200.9300@axis700.grange> <201203062214.53988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58391 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382Ab2CGIb6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Mar 2012 03:31:58 -0500
In-Reply-To: <201203062214.53988.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On 06/03/12 23:14, Rafael J. Wysocki wrote:
> On Tuesday, March 06, 2012, Guennadi Liakhovetski wrote:
>> On Tue, 6 Mar 2012, Adrian Hunter wrote:
>>
>>> On 04/03/12 02:01, Rafael J. Wysocki wrote:
>>>> Hi all,
>>>>
>>>> The goal of this patchset is to allow user space to control the
>>>> responsiveness of the MMC stack related to runtime power management.
>>>
>>> I wonder why this is build into mmc and not just a generic runtime pm
>>> facility. e.g.
> 
> Because of the user space interface (it doesn't necessarily make sense
> for all devices) and to allow drivers to opt-in (if they don't, the interface
> won't be created), which is not possible at the core level (we don't know in
> advance what drivers will handle the given devices and if they will support
> PM QoS).

Even "opt-in" is undesirable, because it is really up to userspace not the
driver.

> 
>>> 	/* Set maximum resume latency target to 100ms */
>>> 	pm_runtime_set_max_latency(dev, 100);
>>>
>>> And then runtime pm will create sysfs attributes etc
>>
>> +1. Having to do essentially exactly the same for each driver subsystem 
>> seems counterproductive.
> 
> Other subsystems need not do that in the same way.

Maybe this needs to be re-thought.  Userspace needs a simple, consistent and
understandable set of pm controls across the entire kernel, not piecemeal
across different subsystems.
