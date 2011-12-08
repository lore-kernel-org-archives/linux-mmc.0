From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: hwmod data: disable multiblock reads on
 MMC1/2 on OMAP34xx/35xx <= ES2.1
Date: Thu, 8 Dec 2011 15:07:13 -0800
Message-ID: <CAGDS+nnASzgu4Xrvm2zqQ2H3uUtZWiKNC+Gb5saqZVLA=-7Scw@mail.gmail.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
 <CAGDS+nnm_+9975aX9h7U7EUf6UDWiiqO8+yfG_zW1sCxhgrzQw@mail.gmail.com>
 <alpine.DEB.2.00.1112081541170.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1112081541170.6289@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Dave Hylands <dhylands@gmail.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 8, 2011 at 2:51 PM, Paul Walmsley <paul@pwsan.com> wrote:

> Thanks for the reminder - I would have forgotten it otherwise.
>
>> Without it 35XXES2.1 systems have broken mmc. =A0Too late as a bug fix f=
or
>> 3.2?
>
> This never worked correctly in previous Linux releases, right?

I seem to recall that it worked a few releases back -- perhaps before
multiblock reads??

It's been broken for a while though, so waiting for 3.3 isn't the end
of the world.

I'll add the patch to my 3.2 builds to put some miles on it :-)

Steve
