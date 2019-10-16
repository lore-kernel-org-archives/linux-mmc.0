From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 23/36] ARM: s3c: move s3cmci pinctrl handling into board
 files
Date: Wed, 16 Oct 2019 15:12:36 +0200
Message-ID: <CACRpkdb07KyJDgACuh2ho822pHAUcw2ubu=WJwqxf8NO-Pv+_A@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-23-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010203043.1241612-23-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 10, 2019 at 10:47 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Rather than call the internal s3c_gpio_cfgall_range() function
> through a platform header, move the code into the set_power
> callback that is already exported by the board, and add
> a default implementation.
>
> In DT mode, the code already does not set the pin config,
> so nothing changes there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

It would feel better if someone was actually testing it on these
boards. I see Ben is listed as maintainer so I bet he will
pull the board out :)

Yours,
Linus Walleij
