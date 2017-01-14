From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RFC] mmc: mxs-mmc: Implement CMD23 support
Date: Sat, 14 Jan 2017 15:40:21 -0200
Message-ID: <CAOMZO5Czy17FytjyHP_pHHqCetDiYyOHaVOFu5hZHjAD=8rHUA@mail.gmail.com>
References: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?B?SsO2cmcgS3JhdXNl?= <joerg.krause@embedded.rocks>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <lw@karo-electronics.de>
List-Id: linux-mmc@vger.kernel.org

Hi Stefan,

On Sat, Jan 14, 2017 at 3:29 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch implements support for multiblock transfers bounded
> by SET_BLOCK_COUNT (CMD23) on the MXS MMC host driver.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Just curious: what is the throughput gain you notice with this patch?

Thanks
