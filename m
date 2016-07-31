From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
Date: Sun, 31 Jul 2016 16:17:24 +0200
Message-ID: <7d813018-49ad-c382-52ec-844f32bbad07@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
 <20160730151619.GR6215@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160730151619.GR6215@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 30-07-16 17:16, Maxime Ripard wrote:
> On Sat, Jul 30, 2016 at 04:25:48PM +0200, Hans de Goede wrote:
>> Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
>> and newer.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> This should probably go through Ulf tree together with the rest of
> that serie to maintain the bisectability.

This going through Ulf's tree is fine with me, and indeed seems best, ack.

Regards,

Hans
