From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: Change the enhanced area related sysfs output format
Date: Tue, 14 Jun 2016 13:36:11 +0300
Message-ID: <575FDE1B.2090206@intel.com>
References: <1465893186-6399-1-git-send-email-beatax.baranowska@intel.com>
 <20160614101242.GA1603@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52247 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbcFNKkS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jun 2016 06:40:18 -0400
In-Reply-To: <20160614101242.GA1603@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Beata Baranowska <beatax.baranowska@intel.com>
Cc: ulf.hansson@linaro.org, aisheng.dong@nxp.com, wsa+renesas@sang-engineering.com, gwendal@chromium.org, chaotian.jing@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sebastianx.jarosz@intel.com, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 14/06/16 13:12, Wolfram Sang wrote:
> On Tue, Jun 14, 2016 at 10:33:06AM +0200, Beata Baranowska wrote:
>> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>>
>> When the enhanced area feature was not enabled, the related sysfs will 
>> have -EINVAL(-22) value, so change the sysfs output format to display 
>> the correct value.
>>
>> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> 
> What about introducing attribute_group an use the is_visible callback
> there, so they won't get displayed at all?
> 

Except that it is an ABI:

	Documentation/ABI/testing/sysfs-devices-mmc
