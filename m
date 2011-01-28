From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] mmc: add double buffering for mmc block requests
Date: Fri, 28 Jan 2011 09:28:48 +0100
Message-ID: <AANLkTi=H71TQpuBnagMThcv-6NKJyqsD-xtg_eW8Pb_T@mail.gmail.com>
References: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
	<4D34FC5D.5080605@samsung.com>
	<AANLkTimjfO4Wb0f87X_sDugW=yU1=YEQn35uZnsKKwq2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <AANLkTimjfO4Wb0f87X_sDugW=yU1=YEQn35uZnsKKwq2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

Have you had the chance to test the patches on the Samsung Soc. I can
sketch a implementation for sdhci if that helps? Unfortunately I don't
have any hardware to test the SDHCI driver unless there is support in
QEMU?
I really think I need to test this on more hardware in order to get
more results for the patchset and hopefully more attention as well.

BR
Per

On 18 January 2011 09:12, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 18 January 2011 03:35, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Hi Per..
>>
>> it is interesting approach..so
>> we want to test your double buffering in our environment(Samsung SoC).
>>
>> Did you test with SDHCI?
> So far I have only tested on mmci for board u5500 and u8500. I happily
> test on a different board if I can get hold of one.
>
>> If you tested with SDHCI, i want to know how much increase the performance.
>>
>> Thanks,
>> Jaehoon Chung
>
