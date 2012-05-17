From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 0/4] mmc: atmel-mci: add support for old mci IPs
Date: Thu, 17 May 2012 20:25:21 +0200
Message-ID: <4FB54291.4080509@atmel.com>
References: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
 <87obpn3rm0.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87obpn3rm0.fsf@laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 05/17/2012 02:43 PM, Chris Ball a =E9crit :
> Hi Ludovic,
>
> On Wed, May 16 2012, ludovic.desroches@atmel.com wrote:
>> This set of patches is an extra step to remove at91-mci dirver which is =
mainly
>> used for old chips having mci IPs whose version is lesser than v2xx (rm9=
200
>> and 9261).
>> Since it introduces many changes and there was a lack of logs to help pe=
ople
>> when there is an issue with atmel-mci driver, I added some debug logs.
>>
>> These changes have been tested on at91rm9200, at91sam9261, at91sam9263,
>> at91sam9g10 and at91sam9g45.
>
> Thanks, pushed all four to mmc-next for 3.5.
>
> - Chris.

Thanks Chris
