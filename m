From: Hu Ziji <huziji@marvell.com>
Subject: Re: [PATCH v7 06/13] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Tue, 4 Apr 2017 01:07:26 +0800
Message-ID: <df6d0972-21ce-589f-d786-7334f526867a@marvell.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
 <ecacddaa5d38b678e1c8c95b56f65f4a39527ead.1490886907.git-series.gregory.clement@free-electrons.com>
 <20170403161926.wfj7foddu33gxuae@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170403161926.wfj7foddu33gxuae@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Stephen Boyd <sboyd@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Wilson Ding <dingwe>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On 2017/4/4 0:19, Rob Herring wrote:
> ----------------------------------------------------------------------
> On Thu, Mar 30, 2017 at 05:22:58PM +0200, Gregory CLEMENT wrote:
>> From: Hu Ziji <huziji@marvell.com>
>>
>> Marvell Xenon SDHC can support eMMC/SD/SDIO.
>> Add Xenon-specific properties.
>> Also add properties for Xenon PHY setting.
>>
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 170 +++++++-
>>  1 file changed, 170 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> 
> I acked v6 and it seems like a minor change, though I had to search for 
> both because there is no revision history nor explanation why you didn't 
> add my ack.
>

	Sorry for missing your ACK.

	I add a few but important comments on common Xenon power implementations
	in the examples. It is recorded in the cover letter.
	v6->v7:
	 - Add comments on vqmmc and vmmc in examples in dt binding doc.

	I was a little unsure if we can still add your ACK after adding the comment.
 	We will add your ACK back if we have to release another version later.

	Thank you.

Best regards,
Hu Ziji

> Acked-by: Rob Herring <robh@kernel.org> 
> 
