From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt: bindings: Add vendor prefix for Espressif System
Date: Thu, 11 Aug 2016 08:31:20 -0500
Message-ID: <CAL_Jsq+uy-P54enk5Zho=nRab4PMEbqyBTEWiE0yhWWVoFTmwQ@mail.gmail.com>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <20160810184845.GA17829@rob-hp-laptop>
 <2b43330e-369d-7473-8b73-429f0f0b73ce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2b43330e-369d-7473-8b73-429f0f0b73ce@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 11, 2016 at 4:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Rob,
>
>
> On 10-08-16 20:48, Rob Herring wrote:
>>
>> On Sun, Aug 07, 2016 at 08:57:48PM +0200, Hans de Goede wrote:
>>>
>>> Espressif is a manufacturer of various wifi and bt chips, add a vendor
>>> prefix for use with bindings for these chips.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
>
> Thank you for all the reviews.
>
> What about: "[PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips" ?
> there were some remarks, but I believe that those have been addressed
> (by answering the remarks, not with a new version), so a review of that
> one would be appreciated too.

What about Arnd's comment "better use '-' instead of '_' for property names."

> Also who should merge this series, Ulf because it is mmc related,
> or the dt-maintainers since it contains only bindings patches ?

I can take it.

Rob
