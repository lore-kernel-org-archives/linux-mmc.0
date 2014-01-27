From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through
 DT
Date: Mon, 27 Jan 2014 11:48:55 +0200
Message-ID: <52E62B87.8010103@ti.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <20140120164859.GF15937@n2100.arm.linux.org.uk>
 <CAOMZO5DdTP0gimwdsBUZK3wXrnUd2FN3w-FszLQkvCwM8gvPpg@mail.gmail.com>
 <52E61C28.1020207@ti.com>
 <CAGb2v64RbXZS_5nvXf9_t=Q=+zrBa=eF-f-xcZTxaMLYSQkNrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v64RbXZS_5nvXf9_t=Q=+zrBa=eF-f-xcZTxaMLYSQkNrw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, chris@printf.net, robh+dt@kernel.org, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 01/27/2014 10:54 AM, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Jan 27, 2014 at 4:43 PM, Jyri Sarha <jsarha@ti.com> wrote:
>> On 01/24/2014 07:35 PM, Fabio Estevam wrote:
...
>> I have not received too much feedback to my patch yet. CCF is a bit new
>> territory to me, but I think having a separate stackable clk-gpio would be
>> more flexible than having the gpio property implemented in clk-fixed-rate.
>
> Not sure where stacking external clocks would be used, but sounds like a
> fixed factor clock? Maybe you should add DT support to that if that's what
> you need or have.
>

Ah, but then there is also the problem of having to change 
clk_register_fixed_rate() in the CCF api, which is called from all over 
the place.

Of course I could add a new clk_register_fixed_rate_gpio(), but still it 
does not look to me like the way to go.

Cheers,
Jyri
