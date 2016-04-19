From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
Date: Tue, 19 Apr 2016 14:21:11 +0200
Message-ID: <571622B7.2010202@schinagl.nl>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
 <57160E06.1000806@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:50418 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbcDSMVR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2016 08:21:17 -0400
In-Reply-To: <57160E06.1000806@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Hans de Goede <hdegoede@redhat.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hey Sergei,

On 19-04-16 12:52, Sergei Shtylyov wrote:
> Hello.
>
> On 4/19/2016 10:12 AM, Olliver Schinagl wrote:
>
>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc
>
>    scripts/checkpatch.pl now enforces certain commit citing style, the 
> commit summary should be specified too.
I used checkpatch from 4.6.0-rc2(or3) and did not notice it. But I'll 
add it to v2.
>
>> device as to having an broken HPI implementation. After talking some
>> with Hans, we now think it is actually the mmc controller that can be
>> broken and not support broken HPI's.
>>
>> This patch adds a new capability, mmc-broken-hpi, which allows us to
>> mark a broken hpi implementation on the host level.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> [...]
>
> MBR, Sergei
>

